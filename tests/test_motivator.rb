require './lib/motivator'
require_relative 'require'
require 'yaml'

class TestMotivator < MiniTest::Test
    
    def setup
        @quotes = YAML.load_file('./lib/quote.yml')
        @colourer = mock('ColourOutput')
        @watcher = mock('FileWatcher')
        @motivation = Motivator.new(@quotes['quotes'], @colourer, @watcher)   
    end

    def test_motivation_class_exists
        assert_kind_of(Motivator, @motivation)
    end

    def test_readable_returns_a_titilized_split_name
        actual = @motivation.readable('steve_jobs')
        assert_equal('Steve Jobs', actual)
    end

    def test_get_specified_author
        jobs_quotes = @quotes['quotes']['steve_jobs']
        assert_includes(jobs_quotes, @motivation.get_quote('steve_jobs'))
    end

    def test_get_specified_author_and_index
       quote = @quotes['quotes']['steve_jobs'][1]
       assert_same(quote, @motivation.get_quote('steve_jobs', 1)) 
    end

    def test_motivate_string_wrapped_in_string_and_color
        quote = @quotes['quotes']['steve_jobs'][1]
        @colourer.expects('random').once.with(' ~ ' + quote).returns(' ~ ' + quote)

        output = @motivation.motivate({author: 'steve_jobs', id: 1})
        assert_equal('Steve Jobs ~ ' + quote, output)
    end
    
end