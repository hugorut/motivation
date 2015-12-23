require 'optparse'

# wrapper class for options parser
class CommandParser
    # pass the config so we can access
    def initialize config
        @config = config
        @options = options
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
            opts.separator ""
            opts.separator "Specifics:"

            opts.on('-m [name]', '--motivate [name]', String, "Receive a motivation boost, you can specify an author with second parameter\n Available authors: #{output_authors}") do |m|
                @options[:method] = 'motivate'
                @options[:arguments] = { author: m }
            end            

            opts.on('-w [files] ', '--watch [files]', Array, 'Watch files to increase productivity, optional parameter which is an array of globs of files to watch e.g. ./tests/*, defaults to everything in the directory that the command is run from' ) do |w|
                @options[:method] = 'watch'
                @options[:arguments] = { files: w }
            end

            opts.on_tail('-h', '--help', 'Output command line help options') do 
                puts opts
                exit
            end
        end

        # set the options from calling the parser if there are any exceptions
        # we need to catch them and output the help message
        begin
            parser.parse!(arguments)    
        rescue Exception => e
            puts parser
            exit(1)
        end

        # if no valid methods were set we can't execute and therefore we exit and
        # put the parser message to the console
        if @options[:method].nil?            
            puts parser
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