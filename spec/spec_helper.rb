$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'pry'
require 'four_o_four'
require 'rack/mock'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
