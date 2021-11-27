source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 5.5'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.5'

# Authentication framework
gem 'devise'
# Argon2 gem for better password hashing
gem 'argon2', '>= 2'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Authorization framework
gem "action_policy"

# ActiveStorage
gem 'image_processing', '~> 1.12'
gem "aws-sdk-s3", require: false

# User-friendly URL Slugs
gem 'friendly_id', '~> 5.4.2'

# Pagination
gem 'kaminari'

# CORS
gem 'rack-cors'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Generate fake seed data
  gem 'factory_bot_rails'
  gem 'faker'

  # Ruby code linting
  gem 'rubocop-rails', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.3'
  gem 'listen', '~> 3.7'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Display better development errors page
  gem 'better_errors'
  # Evaluate code from bindings higher up in the call stack
  gem 'binding_of_caller'

  # Annotate database schema in database-related files
  gem 'annotate'

  # Document Ruby code
  gem 'yard'

  # Ruby security checkers
  gem 'brakeman'
  gem 'bundler-audit'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.36'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # Mocking and stubbing
  gem 'mocha'

  # Improve Minitest output
  # TODO Currently RubyMine does not appear to support minitest-reporters
  gem 'minitest-reporters'

  # Convenient one-line test statements
  gem 'shoulda', '~> 4.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
