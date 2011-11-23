Gem::Specification.new do |s|
  s.name        = 'rubycut-babushka'
  s.version     = '0.10.8'
  s.date        = '2011-11-24'
  s.summary     = "Test-driven sysadmin."
  s.description = "Babushka is a tool for finding, running, writing and sharing recipies to automate things."
  s.authors     = ["Ben Hoskings", "Rubycut"]
  s.email       = ['ben@hoskings.net', "ruby.cutter@gmail.com"]
  s.files       = Dir["lib/**/*.rb", "deps/**/*.rb", "LICENCE", "README.markdown", "spec/**/*", "Rakefile", "Gemfile", "Gemfile.lock"]
  s.homepage    = "https://github.com/rubycut/babushka"
  s.executables = "babushka" 
end
  s.post_install_message = %q{
Gem install is not default type of installation.
  
To install babushka properly, run this command:

    bash -c "`curl babushka.me/up`"
  }
end
