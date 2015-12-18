class Motivation
    attr_accessor :quotes

    def initialize quotes, colourer
        @quotes = quotes['quotes']
        @colourer = colourer
    end

    # main motivation method
    def motivate
        person = @quotes.keys.sample
        quote_length = (@quotes[person].length) -1
        index = Random.rand(0..quote_length)

        @colourer.random(readable(person)) + @colourer.random(" ~ ") + @colourer.random(@quotes[person][index])
    end

    # convert from underscores to spaces and capitalise
    # so the name is readable in the console
    def readable string
        string.sub('_', ' ').split.map(&:capitalize).join(' ')
    end
end