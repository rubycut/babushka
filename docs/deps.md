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

Logging is done nicely, you can use log_ok and similar methods to display messages during testing, and babushka will allgn them for you, see {Babushka::LogHelpers} for details.
    

