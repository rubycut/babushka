## Templating guide

### Variables

### Template changes

If you want to rebuild config file every time you erb template changes, you can use something like this:

    met? { Babushka::Renderable.new(config_filename).from?(dependency.load_path.parent / "rabbit_config.erb") } 
    meet { render_erb "rabbit_config.erb", :to => config_filename, :sudo => true }

*meet* just renders template, everything clear there, but all the magic happens in *met?* block.

We first open target config file, and then use from? method which compares SHA hash added to the top of the config file with sha of the erb file.

So if your erb file changes, config file will be reubilt, but it doesn't work in the opposite direction, you can still change config file and it will not rebuilt it,
providing that you don't touch the first line that babushka added.

### Weird comments

Babushka always adds comments in the begging of file to track changes, so if you are using some language that doesn't support hash (#) comments, you can use this:

    render_erb 'nginx/nginx.launchd.erb', 
      :to => '/Library/LaunchDaemons/org.nginx.plist', 
      :comment => '<!--', 
      :comment_suffix => '-->'