source 'https://rubygems.org'
ruby '2.0.0'

# Backend
gem 'rails', '4.2.0'
gem 'jbuilder', '~> 2.0'
gem 'spring',        group: :development
# gem 'unicorn'
# gem 'rack-timeout'
# gem 'sidekiq'
gem 'simple_form'
gem 'twilio-ruby'
gem 'chronic'
gem 'ransack'
gem 'mixpanel-ruby'
gem 'rollbar', '~> 1.4.4'

# Frontend
gem 'acts-as-taggable-on', '~> 3.4'
gem 'foundation-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# # Auth
gem 'devise'
gem 'devise_uid'
gem 'devise-token_authenticatable'
# gem 'devise_invitable'
# gem 'omniauth'
# gem 'omniauth-twitter'
# gem 'omniauth-facebook'
# gem 'omniauth-linkedin'

# # Analytics
gem 'newrelic_rpm'

# Sitemap
# gem 'sitemap_generator'

# Caching
# gem 'dalli'

# Other
gem 'kaminari'

group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  # gem 'spork-rails', '4.0.0'
  gem 'childprocess'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
  gem 'capybara'
  gem 'twilio-test-toolkit'
  gem 'rspec'
end
