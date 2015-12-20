class Motivation
    attr_accessor :quotes

    def initialize quotes, colourer
        @quotes = quotes['quotes']
        @colourer = colourer
    end

    # main motivation method
    def motivate (opts)
        selected_author = (!opts[:author].nil?) ? opts[:author] : @quotes.keys.sample
        quote_length = (@quotes[selected_author].length) -1
        index = Random.rand(0..quote_length)

        readable(selected_author) + @colourer.random(" ~ " + @quotes[selected_author][index])
    end

    # convert from underscores to spaces and capitalise
    # so the name is readable in the console
    def readable string
        string.sub('_', ' ').split.map(&:capitalize).join(' ')
    end
end