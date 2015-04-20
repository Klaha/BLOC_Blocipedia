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

users.each do |user|
  5.times do
    a = Wiki.create!(
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
    )

    Collaborator.create!(
      user: user,
      wiki: a
    )
  end
end
 
# # Create Wikis
# 50.times do
#   Wiki.create!(
#    title:  Faker::Lorem.sentence,
#    body:   Faker::Lorem.paragraph,
#   )
# end

# wikis = Wiki.all

# # Create Collaborations
# 50.times do
#   Collaborator.create!(
#     user: users.sample,
#     wiki: wikis.sample,
#   )
# end

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Jonathan',
  email: 'klaha.77@gmail.com',
  password: 'helloworld',
  role: 'premium',
  premium: '2015-04-19'
)

user = User.second
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Nathan',
  email: 'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"