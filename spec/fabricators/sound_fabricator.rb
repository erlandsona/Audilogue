Fabricator(:sound) do
  creator { Fabricate(:user)    }
  title   { Faker::Lorem.word   }
  file    { File.new(File.join(Rails.root, 'spec', 'support', 'files', 'myRecording04.wav')) }
end
