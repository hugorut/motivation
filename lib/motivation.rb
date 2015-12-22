class Motivation
    attr_accessor :quotes

    def initialize(quotes, colourer, watcher)
        @quotes = quotes['quotes']
        @colourer = colourer
        @watcher = watcher
    end

    # main motivation method
    def motivate(opts)
        author = (opts[:author].nil?) ? @quotes.keys.sample : opts[:author]

        readable(author) + @colourer.random(" ~ " + get_quote(author, opts[:id]))
    end

    # get a quote, either from random or from specified author or index
    def get_quote(author, index = nil)
        if index.nil?
            quote_length = (@quotes[author].length) - 1
            index = Random.rand(0..quote_length)
        end
        
        @quotes[author][index]
    end

    # convert from underscores to spaces and capitalise
    # so the name is readable in the console
    def readable(string)
        string.sub('_', ' ').split.map(&:capitalize).join(' ')
    end
end