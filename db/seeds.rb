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
require 'JSON'

puts 'Cleaning database...'
Ingredient.destroy_all
puts 'Database cleaned.'

puts 'Creating new ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
json = open(url).read
objs = JSON.parse(json)
objs['drinks'].each do |drink|
  Ingredient.create(name: drink['strIngredient1'])
end

puts "#{Ingredient.all.count} ingredients created."

puts 'Creating 10 cocktails...'

10.times do
  cocktail = Cocktail.new(
    name: Faker::Coffee.blend_name
  )
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

puts '10 cocktails created.'

puts 'All done. Have a nice day.'
