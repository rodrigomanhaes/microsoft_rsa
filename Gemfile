source 'https://rubygems.org'

gem 'rake', '~> 12.0', group: [:test, :development, :release]

group :test do
  gem 'minitest', '~> 5.10'
  gem 'coveralls', require: false
end

group :development do
  gem 'guard', '~> 2.14'
  gem 'guard-minitest', '~> 2.4'
end

group :release do
  gem 'jeweler', '~> 2.3', require: false
end
