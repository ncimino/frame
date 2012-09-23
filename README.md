Frame
=====

Frame is used to instantly setup websites with just a couple of commands.  Frame users several other gems to build the
webpages up.  Once they are created, then they can be fully customized and grow independent of frame.


## Getting Started

To just see what frame was designed to do, create a new project:

```console
rails new tester
cd tester
```

You must add frame as a gem:
```ruby
# Gemfile
gem 'frame'#, :path => '/home/admin/frame/'
```


Then run the bundler:
```console
bundle
```

To just see what frame was designed to do run (you must hit y/a for the overwrites):

```console
rails generate frame:all
rails generate frame:omniauth
rails server

```
