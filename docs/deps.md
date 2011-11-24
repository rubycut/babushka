# Deps Guide

A dep is one single piece of a larger task. A little nugget of code that does just one thing, and does it right. Here's a babushka dep, at its most generic.

    dep 'name' do
      requires 'other deps', 'whatever they might be'
      met? {
        # is this dependency already met?
      }
      meet {
        # this code gets run if it isn't.
      }
    end

The important bit here is that when you're writing a dep, you don't have to think about context at all, just the one little task it's doing in isolation. As long as your `requires` are correct, you can leave the overall structure to babushka and just write each little dep separately. When you run `babushka name`, babushka uses the `requires` in each dep to assemble a tree of deps and achieve the end goal you're after.

The idea is to keep a clean separation between `met?` and `meet`: the code in `met?` should do nothing except just check whether the dep is met and return a boolean, and `meet` should unconditionally satisfy the dep without doing any checks.

## Order of execution

Workflow is that *met?* is executed first, and it if returns false, then *meet* is executed. To make sure *meet* did it's job properly, at the end *met?* is executed one more time to make sure *meet* completed it's task properly. To find out more about what gets executed when, see {Babushka::Dep#process}

## Combining components in deps

If you have existing application which is already installed, and you want to only check if everything is ok, you can write deps with only *met?* part, and they will exist as soon as they find first thing whic is not ok.

Remember, deps are ruby code like everything else, so you can execute them conditionally, for example:

    dep "mysql" do
      if MyApp::Mysql.present?
        requires %w[mysql_installed]
        met? { MyApp::Mysql.connectable? }
      else
        log_ok "I will not further test Mysql"
      end
    end

As you can see, it will check mysql further only if necessary.


## Logging

Logging is done nicely, you can use {Babushka::LogHelpers#log_ok} and similar methods to display messages during testing, and babushka will allign them for you, see {Babushka::LogHelpers} for details.

## Changing flow interactively

You can ask user to confirm certain actions:

    if Babushka::Prompt.confirm(%q{
      I need to checkout stuff from git repo,
      #{var(:home_dir)} exists, although not git repository,
      can I delete #{var(:home_dir)}?"
      }
    )
      var(:home_dir).p.remove
    else
      next unmet("Can't clean dir for git checkout")        
    end


## Structuring deps

Right, here's one I prepared earlier. Given you're on a Mac with Xcode installed, this dep knows how to achieve the goal of having llvm available in the PATH.

    dep 'llvm in path', :for => :snow_leopard do
      requires 'xcode tools'
      met? { which 'llvm-gcc-4.2' }
      meet {
        cd('/usr/local/bin') {|path|
          shell "ln -s /Developer/usr/llvm-gcc-4.2/bin/llvm* .", :sudo => !path.writable?
        }
      }
    end

All the common logic is handled by babushka, which means that all the code in the dep is specific to the job at hand. The idea is maximising that signal-to-noise ratio: as much of the code in the dep above should be talking about llvm, not about other things that can be inferred elsewhere.

Notice that there's no conditional or nested logic within the dep. That's by design: the more declarative things are, the more composable and re-interpretable they are later.

If you find you're checking for the presence of some condition in your `meet` block, it probably means you're trying to do too much in a single dep, and you should be splitting it up into smaller ones. Remember, deps are small, self-contained and context-free - the more focused, the better.

