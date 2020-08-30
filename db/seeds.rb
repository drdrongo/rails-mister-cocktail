# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")

require 'open-uri'
require 'json'

pictures = %w[cocktail_1_fjltrd
              cocktail_2_jk2xwo
              cocktail_3_okx84z
              cocktail_4_fmrjjt
              cocktail_5_xljboq
              cocktail_6_p4va6g
              cocktail_7_sdbazx
              cocktail_8_it7zaj
              cocktail_9_vhrxa1
              cocktail_10_ro1fjr
              cocktail_11_pntxst]

puts 'Cleaning database...'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all
User.destroy_all
SavedCocktail.destroy_all
puts 'Database cleaned.'

puts 'Creating new ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
json = URI.open(url).read
objs = JSON.parse(json)
objs['drinks'].each do |drink|
  Ingredient.create(name: drink['strIngredient1'])
end

puts "#{Ingredient.all.count} ingredients created."

10.times do
  user = User.new(
    first_name: 'Dick',
    last_name: 'Tail',
    email: Faker::Internet.email,
    password: 'secret'
  )
  user.save
end

User.create(
  first_name: 'Hayato',
  last_name: 'Clarke',
  email: 'hayato@gmail.com',
  password: 'secret'
)


puts 'Creating 10 cocktails...'

User.all.each do |user|
  cocktail = Cocktail.new(
    name: Faker::Coffee.blend_name
  ) 
  file = URI.open("https://source.unsplash.com/featured/?cocktail")
  cocktail.photo.attach(io: file, filename: "#{cocktail.name}.jpg", content_type: 'image/jpg')
  
  cocktail.user = user

  cocktail.save
  ingredients = Ingredient.all.sample(3)
  ingredients.each do |ingredient|
    dose = Dose.new(
      description: Faker::Measurement.volume,
      ingredient_id: ingredient.id,
      cocktail_id: cocktail.id
    )
    dose.save
  end
end

User.all.each do |user|
  saved_cocktail = SavedCocktail.new(
    user: user,
    cocktail: Cocktail.all.sample
  )
  saved_cocktail.save
end


puts '10 cocktails created.'

puts 'All done. Have a nice day.'
