require 'optparse'

# wrapper class for options parser
class CommandParser
    # pass the config so we can access
    def initialize config
        @config = config
        @options = options
        @help_called = false
    end

    # default options 
    def options
        { method: nil, arguments: nil}
    end

    # collect the command arguments via the option parser class
    def collect(arguments)
        # build the class options from options parser instance
        parser = OptionParser.new do |opts|
            opts.banner = "Options for output grasshopper"
            opts.separator "\n"
            opts.separator "Specifics:"

            opts.on('-m [name]', '--motivate [name]', String, "# Output a motivational quote") do |m|
                @options[:method] = 'motivate'
                @options[:arguments] = { author: m }
            end            

            opts.on('-w [glob1,glob2] ', '--watch [glob1,glob2]', Array, '# Watch files & output a message on file/folder change event') do |w|
                @options[:method] = 'watch'
                @options[:arguments] = { files: w }
            end

            opts.on_tail('-h', '--help', '# Output command line help options') do 
                @help_called = true
                puts opts
                exit(1)
            end
        end

        # set the options from calling the parser if there are any exceptions
        # we need to catch them and output the help message
        begin
            parser.parse!(arguments)    
        rescue Exception => e
            if not(e.kind_of? SystemExit)
                puts parser
                exit(1)    
            end
        end

        # if no valid methods were set we can't execute and therefore we exit and
        # put the parser message to the console
        if @options[:method].nil?
            puts parser if not @help_called
            exit(1)
        end

        #return the options
        @options
    end

    #output a prett list of authors
    def output_authors
        authors = []

        @config['quotes'].each do |author|
            authors << author[0]
        end

        authors.join(', ')
    end
end