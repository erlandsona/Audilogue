first_name = Faker::Name.first_name
Fabricator(:user) do
  first_name             first_name
  last_name              { Faker::Name.last_name             }
  email                  { Faker::Internet.email(first_name) }
  password               { Faker::Internet.password(8)       }
end
