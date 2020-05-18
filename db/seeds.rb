# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.create(name: 'Ellis Gueplh')
Customer.create(name: 'Royal Anvelope')
Customer.create(name: 'Ellis Mississauga')

User.create(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "Tom", last_name: "Davis")
SuperUser.create!(email: "super@test.com", password: "123456", password_confirmation: "123456", first_name: "Brad", last_name: "Pit")

#####  CSV Ellis Mississauga
require 'csv'

CSV.foreach("lib/seeds/EllisPaperBoxDrawdownIndexCSV2.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Ink.create(row.to_hash)
end