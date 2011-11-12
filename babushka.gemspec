Gem::Specification.new do |s|
  s.name        = 'babushka'
#  s.version     = '0.10.6'
  s.version     = '0.0.1'
  s.date        = '2011-11-12'
  s.summary     = "Test-driven sysadmin."
  s.description = "Babushka is a tool for finding, running, writing and sharing recipies to automate things."
  s.authors     = ["Ben Hoskings"]
  s.email       = 'ben@hoskings.net'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = "http://babushka.me"
  s.executables = "babushka"
  s.add_runtime_dependency 'json', '= 1.5.3'
end