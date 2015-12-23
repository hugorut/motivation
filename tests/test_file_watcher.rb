require_relative 'require'
require './lib/file_watcher'

class TestFileWatcher < MiniTest::Test
    
    def setup
        @files = ['./tests/stubs/*']
        File.open("./tests/stubs/changes.stub", "w") { |file| file.write('test') }
        @file_watcher = FileWatcher.new(@files)
    end

    def teardown
        if File.exists? "./tests/stubs/changes.stub"
            File.delete("./tests/stubs/changes.stub")
        end
    end
    
    def test_snapshot_returns_hash_of_mtime_of_files
        @file_watcher.snapshot_filesystem
        snapshot = @file_watcher.snapshot

        assert_includes(snapshot.keys, './tests/stubs/changes.stub')
    end

    def test_files_changed_returns_files_changes
        # sleep so that the files are not saved in the same second
        sleep(1)

        File.open("./tests/stubs/changes.stub", "w") { |file| file.write('tedddst') }
        @file_watcher.files_changed?

        assert(@file_watcher.changed['./tests/stubs/changes.stub'])
        assert_equal(@file_watcher.event, :change)
    end     

    def test_files_added_returns_new_file_event
        File.open("./tests/stubs/changes2.stub", "w") { |file| file.write('tedddst') }
        @file_watcher.files_changed?

        assert(@file_watcher.changed['./tests/stubs/changes2.stub'])
        assert_equal(@file_watcher.event, :new)

        File.delete("./tests/stubs/changes2.stub")
    end     

    def test_files_added_returns_delete_file_event
        sleep(1)

        File.delete("./tests/stubs/changes.stub")
        @file_watcher.files_changed?

        assert(@file_watcher.changed['./tests/stubs/changes.stub'])
        assert_equal(@file_watcher.event, :delete)
    end 

    def test_files_changed_returns_nil_as_none_changed
        @file_watcher.files_changed?

        assert_nil(@file_watcher.changed)
    end

    def test_watch_method_envokes_proc
        callable = Proc.new do |file, event|
            key = file.has_key? "./tests/stubs/changes.stub"
            assert(true, key)
            assert(event, :change)
            return false
        end
        
        sleep(1)
        File.open("./tests/stubs/changes.stub", "w") { |file| file.write('teafdsdddst') }

        @file_watcher.watch(callable)
    end
end