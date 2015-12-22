class FileWatcher
    attr_reader :snapshot, :changed, :event

    def initialize(files, options = {})    
        @files = files
        @changed = nil
        @event = nil
        @snapshot = snapshot_filesystem
        @options = options
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
        changes = @snapshot.to_a - snapshot_filesystem.to_a

        changes.each do |change|
            if @snapshot.keys.include? change[0]
                @changed = {change[0] => change[1]}
                @event = :change
                return true
            else
                @changed = {change[0] => change[1]}
                @event = :new
                return true
            end
        end

        return false
    end

    # watching the files given in initialize if the files change call the proc
    def watch(have_changed, waiting = nil)
        @watching = true

        while @watching
            if files_changed?
                @watching = have_changed.call(@changed, @event)
            end

            sleep(1)

            if not(waiting)
                puts "waiting"
            else
                waiting.call
            end
        end
    end

end