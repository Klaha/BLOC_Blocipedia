require 'faker'

# Create Users
10.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end

users = User.all
 
# Create Wikis
50.times do
 Wiki.create!(
   title:  Faker::Lorem.sentence,
   body:   Faker::Lorem.paragraph,
   user: users.sample
 )
end

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Jonathan',
  email: 'klaha.77@gmail.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"