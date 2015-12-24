class FileWatcher
    attr_reader :snapshot, :changed, :event

    def initialize(files = nil, options = {})    
        @files = files || ['./*']
        @changed = nil
        @event = nil
        if not @files.empty?
            @snapshot = snapshot_filesystem
        end
        @options = options
    end

    def set_files(files)
        @files = files
        @snapshot = snapshot_filesystem
    end

    # take a snapshot of the given files so we can compare at a given date
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

    # have the given files changed if they have then
    # set the changed file and return true
    def files_changed?
        # initialise variables for the 
        new_snapshot = snapshot_filesystem
        has_changed = false

        # take a new snapshot and subtract this from the old snapshot in order to get forward changes
        # then add the snapshot to the oposite subtraction to get backward changes
        changes = (@snapshot.to_a - new_snapshot.to_a) + (new_snapshot.to_a - @snapshot.to_a)
        
        # determine the event for each change
        changes.each do |change|
            if @snapshot.keys.include? change[0]
                @changed = {change[0] => change[1]}
                @event = (new_snapshot.keys.include? change[0]) ? :change : :delete
                has_changed = true
            else
                @changed = {change[0] => change[1]}
                @event = :new
                has_changed = true
            end
        end
        
        # lets reset the snapshot so that we don't create a forever loop
        @snapshot = new_snapshot

        return has_changed
    end

    # watching the files given in initialize if the files change call the proc
    def watch(have_changed, waiting = nil)
        @watching = true

        while @watching
            if files_changed?
                @watching = have_changed.call(@changed, @event)
            end

            sleep(1)

            waiting.call if waiting
        end
    end

end