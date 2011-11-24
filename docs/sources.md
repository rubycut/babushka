## Storing and distributing deps

You can put your .rb files which contain deps in 3 places:

* .babushka/deps directory inside your home
* babhushka-deps directory inside your project
* inside git repository which you can add 


## Introduction

Babushka only contains the deps that it needs to know how to install itself, and set up a bare minimum of software like package managers, `ruby` and `git`. Everything else is stored separately, in _dep sources_. A dep source is a babushka-managed git repo that contains a bunch of ruby files.

The organisation and naming of the files within the source is completely up to you - babushka will recursively load all the .rb files it can find in the source, in alphabetical order.

You can define deps and templates in the same source, arranged however you like. You don't have to worry about having templates loaded before deps that are defined against them, because the load is a two-stage process that first reads every file and sets up the templates, and then defines all the deps that were found.

The best way manage your own source is to make <tt>~/.babushka/deps</tt> a git repo, and push it to <tt>https://github.com/username/babushka-deps.git</tt>.

To run deps from others' sources, you don't need to add the source explicitly. Just prefix the dep name with the correct username:

    babushka freelancing-god:rvm

The dep source will be cloned into <tt>~/.babushka/sources/freelancing-god</tt>, or updated if it's already there, and then babushka will search for a dep called "rvm" within that source. Because of this partitioning, you don't have to worry about naming conflicts with other people; everything is per-source.

If you want to rename a source, or add one with a custom URL, you can add sources manually like this:

    babushka sources -a custom-name git://example.com/custom/url.git

That will make the source available in <tt>~/.babushka/sources/custom-name</tt>.

There's no configuration file for dep sources; the only state is stored in the contents of <tt>~/.babushka/sources</tt>. Specifically, the source names are the directory names, and the URLs are the locations of the corresponding 'origin' git remotes.

Because of this, you can safely add, remove, rename and edit the directories and repositories in there as much as you like---but importantly, *babushka assumes it has free run of <tt>~/.babushka/sources</tt>, and won't hesitate to `git reset --hard`. If you leave uncommitted or unpushed changes in a source, they'll be lost when that source is updated.*

If you want to write deps just for yourself that you don't plan to push online, just drop them in <tt>~/.babushka/deps</tt>. If you'd rather keep them elsewhere, like in <tt>~/src</tt> or similar, you can symlink the directory into <tt>~/.babushka/deps</tt>.

Finally, babushka also loads deps from `./babushka-deps` in the directory from which it was run. This is a good place for project-specific deps, because you can keep them within the project's source control.

