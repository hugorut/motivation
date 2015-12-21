require 'rubygems'
gem 'minitest'
gem 'mocha'
require 'minitest/autorun'
require 'yaml'
require_relative '../lib/motivation'
require 'mocha/mini_test'

class TestMotivation < MiniTest::Unit::TestCase
    
    def setup
        @quotes = YAML.load_file('./lib/quote.yml')
        @colourer = mock()
        @watcher = mock()
        @motivation = Motivation.new(@quotes, @colourer, @watcher)   
    end

    def test_motivation_class_exists
        check = @motivation.kind_of? Motivation
        assert(true, check)
    end
    
end