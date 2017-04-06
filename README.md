# Resque::Compressible

Transparently compress and decompress resque job payloads!
Useful if you want to minimize memory footprint in redis or
minimize net IO.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque-compressible'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque-compressible

## Usage

Extend it in your resque job after your perform method.

```ruby
class Jobs::Blah
  @queue = :data_pipeline

  def self.perform large_data_1, large_data_2, large_data_3, large_data_4
    puts "large_data_1 is #{large_data_1}"
    puts "large_data_2 is #{large_data_2}"
    puts "large_data_3 is #{large_data_3}"
    puts "large_data_4 is #{large_data_4}"
  end

  extend Resque::Plugins::Compressible
end

```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/resque-compressible.

