class ColourOutput
    attr_accessor :colours, :default

    # initialize and yield self in order to give a hook to modify class
    def initialize()
        @colours = {
            primary: "\033[95m",
            blue: "\033[94m",
            green: "\033[92m",
            warning: "\033[93m",
        }

        @default = "\033[92m"

        yield self if block_given?
    end

    # print out a random color
    def random(string)
        random_key = @colours.keys.sample

        self.send(random_key, string)
    end

    # if the method is missing we need to wrap the argument in a 
    # color from the method call
    def method_missing(name, *args)
        if @colours.include? name
            "#{@colours[name]}#{args[0]}\033[0m"
        else
            "#{@default}#{args[0]}\033[0m"
        end
    end
end