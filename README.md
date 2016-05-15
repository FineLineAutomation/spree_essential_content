# Spree Essential Content [![Build Status](https://secure.travis-ci.org/FineLineAutomation/spree_essential_content.png)](http://travis-ci.org/FineLineAutomation/spree_essential_content)

Spree Essential Content is a fully featured CMS with pages, contents, images and more. It has a blog complete with archives, categories, tags and related products. base for many content related extensions for Spree. It also provides an asset-upload interface.

This is a fork of the excellent spree_essentials gem by @citrus.  The changes to the gem are:
* Use rspec and spree's native test_app rake task instead of Test:Unit and dummier
* No longer including the markdown editor.  It's easier to use the spree_editor gem and set up a rich text editor like TinyMCE.
* We have merged all the spree_essential gems into this one. Since many people actually install all 3 gems to begin with, there is no need to continue to keep them seperate. This decision was made in the interest of maintainability.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

If you don't already have an existing Spree site, [click here](https://github.com/spree/spree) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Spree Essential Content can be installed by itself by adding the following to your Gemfile:

```ruby
gem 'spree_essential_content', github: 'FineLineAutomation/spree_essential_content'
```

If you are using a version of spree lower than 2.4, please see one of the stable branches for the right version of this gem. Please also note I am not maintaining anything below Spree 2.3 now.

Then run:

```bash
bundle install
```

Once that's complete, run the migration generator and migrate your database:

Now run the generator to install the extension.

```bash
rails g spree_essential_content:install
```

Then migrate your database:

```bash
rake db:migrate
```

If that all went smoothly, you should be ready to boot the server with:

```bash
rails s
```

Now login to the admin and click on the 'Content' tab!

------------------------------------------------------------------------------
Notes
------------------------------------------------------------------------------

Spree Essential Content is under constant development... Development is being done on OSX with Ruby 2.3.1 and usually the latest version of Spree. (currently 3.1)

Please let me know if you find any bugs or have feature requests you'd like to see.

------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

In order for you to test, you need to have FireFox installed on your computer.  If you don't you will get an error on all of the tests that require javascript support.

The test suite can be run like so:

```bash
git clone git://github.com/FineLineAutomation/spree_essential_content.git
cd spree_essential_content
bundle install
bundle exec rake test_app
bundle exec rspec
```

------------------------------------------------------------------------------
To Do
------------------------------------------------------------------------------

* better documentation (you know you want to help!)

------------------------------------------------------------------------------
Contributors
------------------------------------------------------------------------------

People Responsible for the Original spree_essentials gem
* Spencer Steffen ([@citrus](https://github.com/citrus))
* Michael Bianco ([@iloveitaly](https://github.com/iloveitaly))
* Victor Zagorski ([@shaggyone](https://github.com/shaggyone))

People that have contributed to @FineLineAutomation's forked version
* Nate Lowrie ([@FineLineAutomation](https://github.com/FineLineAutomation))


If you'd like to help out feel free to fork and send me pull requests!


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2014 Spencer Steffen, citrus, Nate Lowrie & Fine Line Automation, released under the New BSD License All rights reserved.
