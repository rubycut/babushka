## Installing packages

Babhuska provides simplified way to install your gem, deb, rpm from your deps. For example:

    dep "mysql.gem" do
      installs "mysql = 2.8.1"
      provides []
    end

This dep installs exact version of gem. *provides* names executables which should be present in path after installation.
    
## OS dependency

tbd