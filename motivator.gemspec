Gem::Specification.new do |s|
    s.name        = 'motivator'
    s.version     = '1.0.3'
    s.date        = '2015-12-16'
    s.summary     = "Command line motivator"
    s.description = "Quotes to motivate from the command line"
    s.authors     = ["Hugo Rut"]
    s.homepage    = "https://rubygems.org/gems/motivator"
    s.email       = 'hugorut@gmail.com'
    s.files       = Dir["./lib/*"]
    s.license     = 'MIT'
    s.executables << 'motivator'
    s.add_development_dependency('mocha', '~> 1.1.0', '>= 1.1.0')
    s.add_development_dependency('minitest', '~> 5.8.3', '>= 5.8.3')
end