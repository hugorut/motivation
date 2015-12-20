Gem::Specification.new do |s|
    s.name        = 'motivate'
    s.version     = '0.0.0'
    s.date        = '2015-12-16'
    s.summary     = "Command line motivator"
    s.description = "Quotes to motivate from the command line"
    s.authors     = ["Hugo Rut"]
    s.email       = 'hugorut@gmail.com'
    s.files       = ["lib/motivation.rb", "lib/command_parser.rb", "lib/file_watcher.rb"]
    s.license       = 'MIT'
    s.executables << 'motivation'
end