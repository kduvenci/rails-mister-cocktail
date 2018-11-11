# Seeding from www.thecocktaildb.com API
require 'json'
require 'rest-client'

def seed_from_api
  destroy_db # comment it if you want to keep your DB!!
  begin_fetching_data
end

def destroy_db
  if Rails.env.development?
    puts 'Deleting DB. Please wait..'
    Cocktail.destroy_all
    puts 'Cocktails destroyed.'
    Dose.destroy_all
    puts 'Doses destroyed.'
    Ingredient.destroy_all
    puts 'Ingredients destroyed.'
  else
    puts 'Destroy canceled.'
  end
end

def begin_fetching_data
  puts '* Fetching data from www.thecocktaildb.com for cocktail list..'
  url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

  begin
    response = RestClient.get(url)
    cocktail_list = JSON.parse(response.body)['drinks']
    puts '** Fetching succesful for cocktail list!'
    puts '========================================='
    fetch_cocktail_data(cocktail_list)
  rescue StandardError => e
    e.response
  end
end

def fetch_cocktail_data(cocktail_list)
  counter = 0
  cocktail_list.each do |cocktail|
    id = cocktail['idDrink']
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
    begin
      response = RestClient.get(url)
      cocktail = JSON.parse(response.body)['drinks'].first
      puts "*** Fetching succesful for cocktail: #{cocktail['strDrink'].capitalize}."
      save_cocktail(cocktail)
      counter += 1
    rescue StandardError => e
      e.response
    end
  end
  puts "#{counter} cocktails saved succesfuly !!! enjoy ;)"
end

def save_cocktail(cocktail)
  db_cocktail = Cocktail.new(name: cocktail['strDrink'].split(/ |\_|\-/).map(&:capitalize).join(" "))
  db_cocktail.remote_photo_url = cocktail['strDrinkThumb']
  if db_cocktail.save # Validation check and feedback
    puts "Cocktail: #{db_cocktail.name} saved to db succesfuly."
    save_doses(cocktail, db_cocktail)
    puts "\n========================================================\n\n"
  else
    db_cocktail.errors.messages.each do |key, value|
      puts "Saving error of Cocktail: #{db_cocktail.name}"
      puts "Because: #{key} => #{value[0]}"
    end
  end
end

def save_doses(cocktail, db_cocktail)
  # we are going to iterate ingredients in JSON
  index = 1
  puts "\n--- Saving Doses ---------------------------------------"
  15.times do
    measure = cocktail["strMeasure#{index}"].to_s.strip.split(/ |\_|\-/).map(&:capitalize).join(" ")
    ingredient = cocktail["strIngredient#{index}"].to_s.strip.split(/ |\_|\-/).map(&:capitalize).join(" ")

    # Reject empty measure and ingredient pairs
    unless measure.empty? || ingredient.empty?
      measure = measure.empty? ? '1' : measure

      db_ingredient = Ingredient.new(name: ingredient)
      if db_ingredient.save
        puts "=> Ingredient: #{db_ingredient.name} saved to db succesfuly."
      else
        db_ingredient.errors.messages.each do |key, value|
          puts "! Saving error for Ingredient: #{db_ingredient.name}"
          puts "Because: #{key} => #{value[0]}"
        end
        db_ingredient = Ingredient.find_by name: db_ingredient.name
        puts "= Ingredient: #{db_ingredient.name} setted from db."
      end

      db_dose = Dose.new(description: measure)
      db_dose.ingredient = db_ingredient
      db_dose.cocktail = db_cocktail

      if db_dose.save
        print "=> Dose: #{db_dose.description} => "
        puts "#{db_ingredient.name} saved to db succesfuly."
      else
        db_dose.errors.messages.each do |key, value|
          puts "! Saving error for Dose: #{db_dose.description}"
          puts "Because #{key} => #{value[0]}"
        end
      end
    end
    index += 1
  end
end

print `clear`
seed_from_api