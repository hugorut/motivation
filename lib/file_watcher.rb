class FileWatcher

    def initialize(files, options = nil)    
        @files = files
        @options = (options.nil?) ? {} : options
    end

    def watch(&callback)
        @watching = true
        while @watching
            
        end
    end

    # => initalize snapshots of the files we are watching
    # => for file in given files      
        # array[file] = date of modification   
    # => while we are watching the file
        # => run a check on the the filesystem
            # check the pervious snapshot against a current snapshot, any outstanding files have changed
                # [[a, datetime1], [b, datetime3]] - [[a, datetime1], [b, datetime2]] = [[b, datetime3 - datetime2]] 
                # therefore b was changed 
            # set an updated flag with the file and event type new|changed|deleted  
        # => if filesytem has changed
            # pass the files and event to a block   
end