source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'
gem 'rails', '~> 7.0.4'

gem "net-http"

gem 'aws-sdk-s3', '~> 1'
gem 'omniauth-oauth2'
gem 'omniauth-google-oauth2'
gem 'dotenv-rails'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'local_time'
gem 'openssl', '>=2.0.3'
gem 'delayed_job_active_record'
gem 'nokogiri'
gem 'rest-client'
gem 'crono','>=2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
gem 'will_paginate', '~> 3.1.0'
gem 'font-awesome-rails'
gem 'paypal-checkout-sdk'
gem 'friendly_id', '~> 5.4.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Optional dependecy. Adding to avoid asset-related errors when running rails commands
gem "sprockets-rails"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'mimemagic', '~> 0.3.10'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate' # https://github.com/ctran/annotate_models
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
