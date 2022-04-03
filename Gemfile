source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.2"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem "importmap-rails"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Use Sass to process CSS
gem "sassc-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.5"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Authentication framework
gem 'devise'
# Argon2 gem for better password hashing
gem 'argon2', '>= 2'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Authorization framework
gem "action_policy"

# Authorization roles
gem "rolify"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.12"
gem "aws-sdk-s3", require: false

# User-friendly URL Slugs
gem 'friendly_id', '~> 5.4.2'

# Pagination
gem 'kaminari'

# CORS
gem 'rack-cors'

# Efficient tree structure querying
gem 'ancestry'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # NOTE: There is a bug with running a Foreman configuration and this application's configuration that causes an error
  #   loop in a JetBrains IDE. Since in that case we'd be using the JetBrains Debugger anyway, we do not need to load
  #   this library if we are running with a JetBrains IDE.
  gem "debug", platforms: %i[ mri mingw x64_mingw ] unless !!(ENV['RUBYLIB'] =~ /ruby-debug-ide/)

  # Generate fake seed data
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Display better development errors page
  gem 'better_errors'
  # Evaluate code from bindings higher up in the call stack
  gem 'binding_of_caller'

  # Annotate database schema in database-related files
  gem 'annotate'

  # Document Ruby code
  gem 'yard'

  # Ruby code linting
  gem 'rubocop-rails', require: false

  # Ruby security checkers
  gem 'brakeman'
  gem 'bundler-audit'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"

  # Mocking and stubbing
  gem 'mocha'

  # Improve Minitest output
  # TODO Currently RubyMine does not appear to support minitest-reporters
  gem 'minitest-reporters'

  # Convenient one-line test statements
  gem 'shoulda', '~> 4.0'
end
