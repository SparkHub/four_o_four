# FourOFour

[![Build Status][travis]](https://travis-ci.org/SparkHub/four_o_four)
[![Code Climate][gpa]](https://codeclimate.com/github/SparkHub/four_o_four)
[![Test Coverage][coverage]](https://codeclimate.com/github/SparkHub/four_o_four/coverage)

A super simple Rack middleware to capture 404 responses and change the response
for any other logic.

With FourOFour you will be able to handle your 404 responses and change
how your application behave dynamically and with the 'right' way: using a
class for a delegation, separating all the concerns. Routes and logic should
have their own space.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'four_o_four'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install four_o_four

## Usage

After install you need to add this gem as a Rack application within your
application. On rails can be done like this:

```ruby
module YourAwesomeApp
  class Application < Rails::Application
    # .... extra configuration
    config.middleware.insert_before ActionDispatch::RemoteIp, FourOFour
  end
end
```

This will activate every 404 and will take control of the 404 page displaying
a generic page saying

<h1>Default FourOuFour Application</h1>

Please configure your middleware to pass a delegation class

The interesting part comes with the configuration. You can pass a second
parameter to the configuration...

```ruby
module YourAwesomeApp
  class Application < Rails::Application
    # .... extra configuration
    config.middleware.insert_before ActionDispatch::RemoteIp, FourOFour, 'DelegatedClass'
  end
end
```

In this case, the `DelegatedClass` can be any other ruby class that will take
control of the 404 implementing your own logic. This still needs to be a Rack
application compatible. But nothing complicated.

```ruby
class DelegatedClass
  def call(env)
    [200, {'Content-Type' => 'text/html'}, self ]
  end

  def each(&block)
    block.call(random_msg)
  end

  def random_msg
    ["Yo!, this is sad. I didn't know you got this. Sorry ",
     "Dear Mr. or Ms. I'm really sorry about this 404",
     'Such is life'
    ].sample
  end
end
```

## Options

### Skip specific formats

By default, FourOFour will catch any request format. A parameter can be passed to the middleware initialization in order to skip specific formats. The middleware will then ignore these request types.

Example: throw normal 404 page for `json` and `xml` formats:
```ruby
  config.middleware.insert_before ActionDispatch::RemoteIp, FourOFour, 'DelegatedClass',
                                  ['application/json', 'application/xml']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org][rubygems].

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/SparkHub/four_o_four. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant][covenant] code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License][license]

[repo]: https://github.com/SparkHub/four_o_four
[travis]: https://travis-ci.org/SparkHub/four_o_four.svg?branch=master
[gpa]: https://codeclimate.com/github/SparkHub/four_o_four/badges/gpa.svg
[coverage]: https://codeclimate.com/github/SparkHub/four_o_four/badges/coverage.svg
[license]: http://opensource.org/licenses/MIT
[rubygems]: https://rubygems.org
[covenant]: http://contributor-covenant.org
