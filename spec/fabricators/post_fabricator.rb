Fabricator(:post) do
  author(fabricator: :user)
  title { Faker::Lorem.words(4) }
  body { Faker::Lorem.paragraph(2) }
end
