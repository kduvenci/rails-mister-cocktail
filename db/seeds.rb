Cocktail.destroy_all if Rails.env.development?
Dose.destroy_all if Rails.env.development?
Ingredient.destroy_all if Rails.env.development?

i_1 = Ingredient.create(name: "lemon")
i_2 = Ingredient.create(name: "ice")
i_3 = Ingredient.create(name: "mint leaves")
i_4 = Ingredient.create(name: "soda")
i_5 = Ingredient.create(name: "rye")
i_6 = Ingredient.create(name: "Angostura bitters")


c_0 = Cocktail.new(name: "Mojito")
c_0.remote_photo_url = 'https://cdn.liquor.com/wp-content/uploads/2018/09/04153106/mojito-720x720-recipe.jpg'
c_0.save

c_1 = Cocktail.new(name: "Old Fashioned")
c_1.remote_photo_url = 'https://cdn.liquor.com/wp-content/uploads/2017/08/08074649/6-Rules-for-Drinking-Bourbone-bourbon-old-fashioned-720x720-slideshow.jpg'
c_1.save

c_2 = Cocktail.new(name: "Negroni")
c_2.remote_photo_url = 'http://cdn.liquor.com/wp-content/uploads/2016/04/15115430/NegroniOriginal720FB.jpg'
c_2.save

c_3 = Cocktail.new(name: "Whiskey Sour")
c_3.remote_photo_url = 'https://cdn.liquor.com/wp-content/uploads/2017/11/06162323/amaretto-sour-1200x628-social.jpg'
c_3.save

c_4 = Cocktail.new(name: "Dry Martini")
c_4.remote_photo_url = 'https://cdn.diffordsguide.com/contrib/stock-images/2016/1/19/20161219e7cab35505de3992419d949a430e.jpg'
c_4.save

d_1 = Dose.create(description: "1 pcs", ingredient_id: i_1.id, cocktail_id: c_0.id)
d_2 = Dose.create(description: "1 pcs", ingredient_id: i_2.id, cocktail_id: c_0.id)
d_3 = Dose.create(description: "1 pcs", ingredient_id: i_3.id, cocktail_id: c_0.id)

d_4 = Dose.create(description: "1 pcs", ingredient_id: i_1.id, cocktail_id: c_1.id)
d_5 = Dose.create(description: "2 pcs", ingredient_id: i_2.id, cocktail_id: c_2.id)