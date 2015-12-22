class FileWatcher
    attr_reader :snapshot, :changed, :event

    def initialize(files, options = nil)    
        @files = files
        @changed = nil
        @event = nil
        @snapshot = snapshot_filesystem
        @options = (options.nil?) ? {} : options
    end

    def snapshot_filesystem
        mtimes = {}

        files = @files.map { |file| Dir[file] }.flatten.uniq
        
        files.each do |file|
            if File.exists? file
                mtimes[file] = File.stat(file).mtime
            end
        end

        mtimes
    end

    def files_changed?
        changes = @snapshot.to_a - snapshot_filesystem.to_a

        changes.each do |change|
            if @snapshot.keys.include? change
                @changed = {change[0] => change[1]}
                @event = :change
                return true
            else
                @changed = {change[0] => change[1]}
                @event = :new
                return true
            end
        end
    end

    # def watch(&proc)
    #     @watching = true
    #     while @watching
            
    #     end
    # end

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