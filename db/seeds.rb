# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: 'manager',
  email: 'admin@example.co',
  password: 'admin123',
  role: 'admin'
  )
puts 'Default admin user created'

Category.destroy_all

category_list = [
  { name: "景點"},
  { name: "餐廳"},
  { name: "車站"},
  { name: "購物"},
  { name: "自訂"}
]

category_list.each do |category|
  Category.create( name: category[:name])
end

puts "Category created!"
