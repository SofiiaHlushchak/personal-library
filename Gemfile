# frozen_string_literal: true

source "https://rubygems.org"

gem "bcrypt", "~> 3.1.7"
gem "devise", "~> 4.9", ">= 4.9.3"
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "dotenv-rails"
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "rubocop", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
