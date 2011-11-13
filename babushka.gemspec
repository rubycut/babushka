Gem::Specification.new do |s|
  s.name        = 'babushka'
  s.version     = '0.10.6'
  s.date        = '2011-11-13'
  s.summary     = "Test-driven sysadmin."
  s.description = "Babushka is a tool for finding, running, writing and sharing recipies to automate things."
  s.authors     = ["Ben Hoskings", "Rubycut"]
  s.email       = ['ben@hoskings.net', "ruby.cutter@gmail.com"]
  s.files       = Dir["lib/**/*.rb", "deps/**/*.rb", "LICENCE", "README.markdown", "spec/**/*", "Rakefile", "Gemfile", "Gemfile.lock"]
  s.homepage    = "https://github.com/rubycut/babushka/tree/gem"
  s.executables = "babushka" 
end