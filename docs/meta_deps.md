## Meta deps

## let's get declarative

The basic dep, with just `requires`, `met?` and `meet`, is all you need to describe an end goal. But this generic nature of `met?` and `meet` means just as they're general purpose, they can lack focus. For example, installing an app using the system's package manager has a predictable `met?` block---check whether the package is present and its binaries are in the path.

A lot of chores are variations on a theme like this, or just too cumbersome to do repeatedly at a low level. So babushka provides a way to write dep templates, or _meta deps_, that can be reused later. These meta deps allow you to focus the DSL, and make it even more concise.

For example, Babushka ships with a meta dep that knows how to install TextMate bundles, given just the URL. All the actual logic, including the code for `met?` and `meet`, is wrapped up in the meta dep.

    meta :tmbundle, :for => :osx do
      accepts_list_for :source

      template {
        requires 'TextMate.app'
        def path
          '~/Library/Application Support/TextMate/Bundles' / name
        end
        met? { path.dir? }
        before { shell "mkdir -p #{path.parent}" }
        meet {
          source.each {|uri|
            git uri, :to => path
          }
        }
        after { shell %Q{osascript -e 'tell app "TextMate" to reload bundles'} }
      }
    end

Notice how the contents of the `template` block looks like a normal dep. That's cause it is---the meta dep is a factory, that takes values defined by `accepts_list_for` (in this case, `source`) and produces regular deps at runtime under the covers.

Given the `tmbundle` meta dep, this dep handles the cucumber bundle:

    dep 'Cucumber.tmbundle' do
      source 'https://github.com/bmabey/cucumber-tmbundle.git'
    end

Notice there's no imperative code there at all---just declarations. That's what the DSL aims for. Instead of saying "do this, then do this, then do this", the code should say "here's a description of the problem, now you work it out." Also notice that there's no TextMate-specific logic. Adding this extra level of abstraction means all that's left are the specifics for _this_ TextMate bundle.

