class Motivator
    attr_accessor :quotes

    def initialize(quotes, colourer, watcher)
        @quotes = quotes
        @colourer = colourer
        @watcher = watcher
    end

    # output a string of motivation to the console prepended by the 
    # quotes author and coloured with ansi character codes
    def motivate(opts = {})
        author = (opts[:author].nil?) ? @quotes.keys.sample : opts[:author]

        readable(author) + @colourer.random(" ~ " + get_quote(author, opts[:id]))
    end

    # watch the files in the system and call the files changed method as a 
    # proc when there is an event that we need to hook into
    def watch(opts)
        @watcher.set_files(opts[:files]) if opts[:files]
        @watcher.watch(method(:files_changed))
    end

    # the callable method which contains the logic once files are changed
    def files_changed(file, event)
        puts motivate
        # return true so that the watch loop keeps running
        return true
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
        string.gsub('_', ' ').split.map(&:capitalize).join(' ')
    end
end