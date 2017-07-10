require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
ENV['COVERAGE'] && SimpleCov.start do
  add_filter '/.rvm/'
end

require 'microsoft_rsa'
require 'minitest/autorun'
