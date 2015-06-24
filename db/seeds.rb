# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []
4.times do
  users << Fabricate(:user)
end
users << Fabricate(:user, first_name: "Austin", last_name: "Erlandson", email: "austin@erlandson.com", password: "Erlandson77")

75.times do
  Fabricate(:sound, creator: users.sample)
end

