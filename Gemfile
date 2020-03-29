# A sample Gemfile
source "https://rubygems.org"

gem 'rake', "~> 13.0.1"
gem 'activesupport', "~> 6.0.2.2"

gem 'sinatra', "~> 2.0.8.1"
gem 'sinatra-contrib', "~> 2.0.8.1"
gem 'sinatra-activerecord', "~> 2.0.14"

gem 'thin', "~> 1.7.2"
gem 'tux', "~> 0.3.0"

gem 'opencage-geocoder', "~> 2.1.2"

# These gems are only installed when run as `bundle install --without production`
group :development, :test do
  gem 'rspec', "~> 3.9.0"
  gem 'webmock', "~> 3.8.3"
  gem 'pry', "~> 0.13.0"
  gem 'shotgun', "~> 0.9.2"
  gem 'sqlite3', "~> 1.4.2"
end

# bundle install --without test --without development
group :production do
  # use postgres in production, or move outside a group if your app uses postgres for development and production
  gem 'pg', "~> 1.2.3"
  gem 'pry', "~> 0.13.0"
end
