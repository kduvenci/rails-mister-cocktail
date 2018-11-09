Cocktail.destroy_all if Rails.env.development?
Dose.destroy_all if Rails.env.development?
Ingredient.destroy_all if Rails.env.development?

i_1 = Ingredient.create(name: "lemon")
i_2 = Ingredient.create(name: "ice")
i_3 = Ingredient.create(name: "mint leaves")
i_4 = Ingredient.create(name: "soda")
i_5 = Ingredient.create(name: "rye")
i_6 = Ingredient.create(name: "Angostura bitters")


c_1 = Cocktail.create(name: "Old Fashioned")
c_2 = Cocktail.create(name: "Negroni")
c_3 = Cocktail.create(name: "Whiskey Sour")
c_4 = Cocktail.create(name: "Dry Martini")

d_1 = Dose.create(description: "1 pcs", ingredient_id: i_1.id, cocktail_id: c_1.id)
d_2 = Dose.create(description: "2 pcs", ingredient_id: i_2.id, cocktail_id: c_2.id)