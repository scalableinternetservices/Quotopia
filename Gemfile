source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem "less-rails"
gem 'twitter-bootstrap-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# devise for user accounts
gem 'devise'

# Use kaminari as the pagination engine
gem 'kaminari'
# twitter-typeahead-rails for typeahead
gem 'twitter-typeahead-rails', :git => "git://github.com/yourabi/twitter-typeahead-rails.git"
# elasticsearch for inverted index
gem 'elasticsearch'
gem 'elasticsearch-model'
gem 'elasticsearch-persistence'
gem 'elasticsearch-rails'
# mysql gem driver for prod and test
gem 'mysql'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# twitter integration
gem 'omniauth-twitter'
gem 'twitter'
gem 'omniauth'

# for mysql Triggers
gem 'hairtrigger'
# multi_json for aws
gem 'multi_json', '1.7.8'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring','~> 1.3.6'
  
  # Rack mini profile for performance monitoring
  gem 'rack-mini-profiler'

  # Flamegraphs for performance visualization
  gem 'flamegraph'

  # Fabricator to create test data
  gem 'fabrication'

  # Faker to help Fabricator
  gem 'faker'

  gem 'seed_dump'
  
# Dependency for flamegraph
  gem 'stackprof'

  # Bullet finds where you can reduce queries
  gem 'bullet'
end

group :production do
  gem 'mysql2'
  gem 'newrelic_rpm'
end

gem 'mocha', group: :test

# new relic performance monitoring
gem 'newrelic_rpm'

