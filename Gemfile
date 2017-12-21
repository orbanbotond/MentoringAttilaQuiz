source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

#TRAILBLAZER

  gem "simple_form"
  # gem "formular", github: "trailblazer/formular"
  gem "dry-validation"

  gem "trailblazer", ">= 2.0.3"
  gem "trailblazer-rails"
  gem "trailblazer-cells"
  gem "cells-rails"
  gem "cells-slim"
  gem 'formular'

gem 'devise'
gem 'rolify'
gem 'cancancan'

gem 'paper_trail'

gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'bootstrap-sass', '~> 3.3'
gem 'bootstrap_form'
gem 'rails_bootstrap_navbar' # TODO: delete after trailblazer arhitecture finalized

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test, :production do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.14'
  gem 'rspec-rails', '~> 3.5'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'slim', '~> 3.0'
  gem 'slim-rails', '~> 3.0'

  gem 'nested_form_fields'
  gem 'nested_form'
  gem 'nested_scaffold'

  gem 'jquery-rails'

  gem 'chromedriver-helper'

  gem 'will_paginate', '~> 3.1.0'

  gem 'filterrific'

  gem 'pry-rails'
  gem 'pry-nav'

  gem 'elasticsearch', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git' 
  gem 'elasticsearch-dsl'
  gem 'elasticsearch-model'
  gem 'chewy'
  gem 'factory_girl_rails'

  gem 'elasticsearch-extensions'
  gem 'bonsai-elasticsearch-rails'

  gem 'wicked'

  gem 'rubocop', '~> 0.49.1', require: false

  gem 'toastr-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
