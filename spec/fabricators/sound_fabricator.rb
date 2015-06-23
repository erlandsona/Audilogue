Fabricator(:sound) do
  creator { Fabricate(:user)    }
  title   { Faker::Lorem.word   }
  url     { Faker::Internet.url }
end
