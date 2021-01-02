source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
gem 'rubocop', '~> 0.89.1'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
gem 'devise'
gem 'font_awesome5_rails', '~> 1.2.0'
gem 'rubocop-rails', '~> 2.8.1'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 1.1'
gem 'simple_form', '~> 5.0', '>= 5.0.3'
gem 'slim-rails', '~> 3.2.0'
gem 'bootstrap4-kaminari-views'
gem 'factory_bot_rails'
gem 'faker'
gem 'kaminari'
gem 'premailer-rails'
gem 'pundit'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.13.1'
  gem 'amazing_print'
  gem 'annotate'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop-rspec', '~> 1.43', '>= 1.43.2', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 3.33'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'simplecov', '= 0.17', require: false
end

group :production do
  gem 'wkhtmltopdf-heroku'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
