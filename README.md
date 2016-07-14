# PromocodeGenerator

 This is an OOP implementation and modified version of the
 ruby implementation of  https://github.com/grantm/Algorithm-CouponCode

 From the website above:
 ```quote
 The code generation algorithm avoids 'undesirable' codes.
 For example any code in which transposed characters happen to result in a valid checkdigit will be skipped.
 Any generated part which happens to spell an 'inappropriate' 4-letter word (e.g.: 'P00P') will also be skipped.
 ```

 This gem does not include algorithmic validation. That's a TODO.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'promocode_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promocode_generator

## Usage

Usage:
 generator = PromocodeGenerator::Generator.new(length: 10, prefix: 'CNN')
 codes = []
 10.times { codes << generator.generate }
 puts codes

## Development

After checking out the repo, run `bin/setup` to install dependencies. 
Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and 
then run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Benchmark

Benchmarking test results for 100_0000
```ruby
n = 100_000

h = PromocodeGenerator::Generator.new(length: 10, prefix: 'CNN')
<PromocodeGenerator::Generator:0x007fa29d6daff0
        @length=10,
        @prefix="CNN",
        @retries=0,
        @rules={:exclusion=>{:excluded_characters=>"AEIOU10"}},
        @symbols_used="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890">

Benchmark.bm { |x| x.report { n.times { h.generate }}}
        user     system      total        real
     3.890000   0.030000   3.920000 (  3.954316)

<PromocodeGenerator::Generator:0x007fa29d6daff0
        @length=10,
        @prefix="CNN",
        @retries=7996,
        @rules={:exclusion=>{:excluded_characters=>"AEIOU10"}},
        @symbols_used="BCDFGHJKLMNPQRSTVWXYZ23456789">
```

Even with 7996 retries we can generate 100_000 coupons within 4 seconds

```shell
for  1_000_000
      user     system      total        real
  36.730000   0.190000  36.920000 ( 37.350304)
```

```shell
for 10_000_000
      user     system      total        real
378.320000   3.560000 381.880000 (398.113595)
```
following the pattern above the approximate time for generating 100_000_000 codes would be around an hour and a half

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ksekhar/promocode_generator. 
This project is intended to be a safe, welcoming space for collaboration, and 
contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

