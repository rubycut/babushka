## Reading documentation

This file and other guides are written using yard, best place to read docs is:

http://rubydoc.info/gems/rubycut-babushka/frames

# About this repo

While using this gem, keep in mind:

* This software is packaged as rubycut-babushka, since author asked us not to use babushka as gem name since he wants to keep only one way of installing babushka (see https://github.com/benhoskings/babushka/issues/173 for details)
* by using this babushka as gem, it is not possible for babushka to configure ruby and rubygems 
* switching the active rvm/rbenv ruby, or installing a new ruby that shadows the existing one, changes the set of gems that are in the path, which would make it look like babushka had disappeared.
* lot of tools are confined to a single set of gems, or a single bundle. But babushka should exist outside of those things so it can configure them.
* This is unstandard way to install babushka, standard way is explained at: http://babushka.me/installing
* This gem is built using https://github.com/rubycut/babushka, we try to follow main repo but can not guearantee that we will produce gem same day official babushka version comes out
* we will not be adding any new code to babhushka source code for now, but we will add more source documentation


## Development status

This gem is not fully tested in realistic environment, although all the spec work.

# babushka: test-driven sysadmin.

When you spend time researching something new, it's pretty easy to forget what you found, and have to re-research it again next time.

A lot of the tech jobs we do manually aren't challenging or fun, but they're finicky and have to be done just right. They're chores. Things that are important to do, but that are better automated than done manually by us people, right? After all, that's what is supposed to happen in the future. And the future is good, because in the future, we'll all have jetpants. So, onward.

The idea is this: you take a job that you'd rather not do manually, and describe it to babushka using its DSL. The way it works, babushka not only knows how to accomplish each part of the job, it also knows how to check if each part is already done. You're teaching babushka to achieve an end goal with whatever runtime conditions you throw at it, not just to perform the task that would get you there from the very start.

## Beginner



* {file:docs/deps.md Deps Guide} - Best place to start is it will teach you  what deps is, and how to write one.
* {file:docs/templates.md Templating Guide} - generating (config) files files based on templates
* {file:docs/packages.md Packages guide} - Babushka can help you install gem, deb, rpm and other packages
* {file:docs/sources.md Sources Guide} - Where to save your deps and how to ditribute them

## Advanced

* {file:docs/meta_deps.md Meta Deps Guide}

# a runtime example

All that means that babushka isn't just blindly running a bunch of code to make things happen. Each step of the way, it's checking what should be done, and only doing the bits that aren't done already. (In babushka parlance, it's only meeting dependencies that aren't already met.)

If you already have TextMate installed, babushka notices and just installs the bundle.

    Cucumber.tmbundle {
      TextMate.app {
        Found at /Applications/TextMate.app.
      } √ TextMate.app
      not already met.
      Cloning from https://github.com/bmabey/cucumber-tmbundle.git... done.
      Cucumber.tmbundle met.
    } √ Cucumber.tmbundle

But if you don't have TextMate, that's an unmet dependency, so it gets pulled in too.

    Cucumber.tmbundle {
      TextMate.app {
        not already met.
        Downloading http://download-b.macromates.com/TextMate_1.5.9.dmg... done.
        Attaching TextMate_1.5.9.dmg... done.
        Found TextMate.app in the DMG, copying to /Applications... done.
        Detaching TextMate_1.5.9.dmg... done.
        Found at /Applications/TextMate.app.
        TextMate.app met.
      } √ TextMate.app
      not already met.
      Cloning from https://github.com/bmabey/cucumber-tmbundle.git... done.
      Cucumber.tmbundle met.
    } √ Cucumber.tmbundle



## WARNING

A dep can run any code. Run deps of unknown origin at your own risk, and when choosing deps and dep sources, use the only real security there is: a network of trust.

Many deps will change your system irreversibly, which is kind of the whole point, but it has to be said anyway. Use caution and always have a backup.


## acknowledgements

[Fancypath](http://github.com/tred/fancypath/), by [Myles Byrne](http://www.myles.id.au/) & [Chris Lloyd](http://thelincolnshirepoacher.com/). It's how I made the paths so fancy.

[Levenshtein](http://raa.ruby-lang.org/project/levenshtein/), for typo correction. Thanks to [Paul Battley](http://twitter.com/threedaymonk) for letting me dual-license it under BSD.

Thanks to my rubyist friends who've helped with brainstorming and testing---the likes of
[@glenmaddern](http://twitter.com/glenmaddern),
[@nathan_scott](http://twitter.com/nathan_scott),
[@notahat](http://twitter.com/notahat),
[@quamen](http://twitter.com/quamen),
[@dgoodlad](http://twitter.com/dgoodlad),
[@chrisberkhout](http://twitter.com/chrisberkhout),
[@pat](http://twitter.com/pat),
[@brentsnook](http://twitter.com/brentsnook),
[@odaeus](http://twitter.com/odaeus),
[@lachlanhardy](http://twitter.com/lachlanhardy),
[@aussiegeek](http://twitter.com/aussiegeek),
[@bjeanes](http://twitter.com/bjeanes),
[@chendo](http://twitter.com/chendo),
[@ryanbigg](http://twitter.com/ryanbigg) &
[@drnic](http://twitter.com/drnic).


## license

Babushka is licensed under the BSD license, except for the following exception:

lib/support/levenshtein.rb, which is licensed under the MIT license.

The BSD license can be found in full in the LICENSE file, and the MIT license at the top of lib/support/levenshtein.rb.
