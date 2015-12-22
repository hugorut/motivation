require_relative 'require'
require './lib/file_watcher'

class TestFileWatcher < MiniTest::Unit::TestCase
    
    def setup
        @files = ['./tests/stubs/*']
        File.open("./tests/stubs/changes.stub", "w") { |file| file.write('test') }
        @file_watcher = FileWatcher.new(@files)
    end

    def teardown
        File.delete("./tests/stubs/changes.stub")
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

        assert_includes(@file_watcher.changed.keys, './tests/stubs/changes.stub')
    end 

    def test_files_changed_returns_nil_as_none_changed
        @file_watcher.files_changed?

        assert_nil(@file_watcher.changed)
    end

    def test_watch_method_envokes_proc
        callable = Proc.new do |file, event|
            p file
            p event
            return false
        end
        
        sleep(1)
        File.open("./tests/stubs/changes.stub", "w") { |file| file.write('teafdsdddst') }

        @file_watcher.watch(callable)
    end
end