# Spree Essentials [![Build Status](https://secure.travis-ci.org/FineLineAutomation/spree_essentials.png)](http://travis-ci.org/FineLineAutomation/spree_essentials)

Spree Essentials is the base for many content related extensions for Spree. It doesn't do much on it's own ;)

Spree Essentials provides other extensions with:

* An asset-upload interface
* Image picker for embedding uploaded images into markdown editor
* A common navigation tab ("Content")
* A shared `spec_helper.rb`

Current essential-aware extensions include:

* [spree_essential_cms](https://github.com/FineLineAutomation/spree_essential_cms): A full featured CMS with pages, contents, images and more
* [spree_essential_blog](https://github.com/FineLineAutomation/spree_essential_blog): A blog complete with archives, categories, tags and related products

This is a fork of the excellent spree_essentials gem by @citrus.  The changes to the gem are:
* Use rspec and spree's native test_app rake task instead of Test:Unit and dummier
* No longer including the markdown editor.  It's easier to use the spree_editor gem and set up a rich text editor like TinyMCE.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

If you don't already have an existing Spree site, [click here](https://github.com/spree/spree) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Spree Essentials can be installed by itself by adding the following to your Gemfile:

```ruby
# Spree 1.3.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '1-3-stable'

# Spree 1.2.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '1-2-stable'

# Spree 1.1.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '1-1-stable'

# Spree 1.0.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '1-0-stable'

# Spree 0.70.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '0-70-stable'

# Spree 0.30.x
gem 'spree_essentials', :git => 'git@github.com:FineLineAutomation/spree_essentials.git', :branch => '1-3-stable'
```

Be sure to only include the gem line that cooresponds to your spree version.  Do not put all of the above lines in your gem file.  Please also note I am not maintaining anything below Spree 1.2.

This isn't necessary if you're using spree_essentials based extensions. If that's the case, just include the extensions normally:

```ruby
gem 'spree_essential_cms', :git => 'git@github.com:FineLineAutomation/spree_essential_cms.git', :branch => '1-3-stable'
gem 'spree_essential_blog', :git => 'git@github.com:FineLineAutomation/spree_essential_blog.git', :branch => '1-3-stable'
```

Then run:

```bash
bundle install
```

Once that's complete, run the migration generator and migrate your database:

To see your available generators run

```bash
rails g
```

Now run the generators for extensions you wish to install

```bash
rails g spree_essentials:install
rails g spree_essentials:cms
rails g spree_essentials:blog
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
Deploying
------------------------------------------------------------------------------

Follow these steps if you plan host your attachments with a CDN like amazon s3. This is useful when deploying to [heroku](http://heroku.com).

First, add the [aws-sdk](http://rubygems.org/gems/aws-sdk) gem to your `Gemfile`

```ruby
gem 'aws-sdk', '~> 1.3'
```

Then run:

```bash
bundle install
```


Next, create some buckets on s3. I use the [s3cmd](http://s3tools.org/s3cmd).

```bash
s3cmd mb s3://yoursite.dev --acl-public
s3cmd mb s3://yoursite.com --acl-public
```


Now create a config file for s3 in `config/s3.yml`

```yml
# config/s3.yml
defaults: &defaults
  s3_protocol: http
  access_key_id: YOUR_KEY
  secret_access_key: YOUR_SECRET
  bucket: yoursite.dev

development:
  <<: *defaults

test:
  <<: *defaults

production:
  <<: *defaults
  bucket: yoursite.com
```


Lastly, create a [decorator](http://guides.spreecommerce.com/logic_customization.html) for the upload model in `app/models/spree/upload_decorator.rb`.

```ruby
# app/models/spree/upload_decorator.rb
Spree::Upload.attachment_definitions[:attachment].merge!(
  :storage        => 's3',
  :s3_credentials => Rails.root.join('config', 's3.yml'),
  :path           => "/uploads/:id/:style/:basename.:extension"
)
```


If you're using the [CMS](https://github.com/FineLineAutomation/spree_essential_cms) or [blog](https://github.com/FineLineAutomation/spree_essential_blog) extensions you can set the config on each model like so:

```ruby
# app/models/spree/asset_decorator.rb
[ Spree::Content, Spree::PageImage, Spree::PostImage, Spree::Upload ].each do |cls|
  cls.attachment_definitions[:attachment].merge!(
    :storage        => 's3',
    :s3_credentials => Rails.root.join('config', 's3.yml'),
    :path           => "/:class/:id/:style/:basename.:extension"
  )
end
```


That's all there is to it!


------------------------------------------------------------------------------
Notes
------------------------------------------------------------------------------

Spree Essentials is under constant development... Development is being done on OSX with Ruby 1.9.3 and usually the latest version of Spree. (currently 1.1.0)

Please let me know if you find any bugs or have feature requests you'd like to see.


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

In order for you to test, you need to have FireFox installed on your computer.  If you don't you will get an error on all of the tests that require javascript support.

The test suite can be run like so:

```bash
git clone git://github.com/FineLineAutomation/spree_essentials.git
cd spree_essentials
bundle install
bundle exec rake test_app
bundle exec rake
```

------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

You can easily use the test/dummy app as a demo of spree_essentials. Just `cd` to where you develop and run:

```bash
git clone git://github.com/FineLineAutomation/spree_essentials.git
cd spree_essentials
bundle install
bundle exec rake test_app
cd spec/dummy
rails s
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

Copyright (c) 2013 Spencer Steffen, citrus, Nate Lowrie & FineLineAutomation, released under the New BSD License All rights reserved.
