require_relative 'require'
require './lib/colour_output'

class TestColourOutput < MiniTest::Test
        
    def test_yields_self_on_init
        ColourOutput.new do |color|
            assert_kind_of(ColourOutput, color)
        end        
    end

    def test_string_wrapped_in_specified_color_from_missing_method_call
        color = "\033[91m"
        ending = "\033[0m"
        string = 'this is a test string'

        colourer = ColourOutput.new do |c|
            c.colours[:test] = color
        end 

        output = colourer.test(string)
        assert_equal(color + string + ending, output)
    end    

    def test_string_wrapped_in_default_color_from_if_name_does_not_exist_in_hash
        default = "\033[91m"
        ending = "\033[0m"
        string = 'this is a test string'

        colourer = ColourOutput.new do |c|
            c.default = default
        end 

        output = colourer.test(string)
        assert_equal(default + string + ending, output)
    end

    def test_random_calls_a_random_colour_to_wrap_around_string
        string = 'this is a test string'
        colourer = ColourOutput.new

        output = colourer.random(string)
        assert_includes(output, string)
    end
    
end