source 'https://rubygems.org'
ruby '2.2.2'


gem 'bourbon'
gem 'bitters'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0' #default
gem 'carrierwave'
gem 'devise'
gem 'faker'
gem 'figaro'
gem 'fog'
gem 'haml-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'kaminari'
gem 'neat'
# Use postgresql as the database for Active Record
gem 'pg' #default with postgresql:)
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1' #default
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0' #default
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'simple_form'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0' #default

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'refills'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'erb2haml'
  gem 'fabrication'
  gem 'rspec-rails'

  # Guard is a watcher for your test files. Super cool...
  gem 'guard-rspec', require: false


  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
end


group :production do
  gem 'puma'
  gem 'rails_12factor'
end
