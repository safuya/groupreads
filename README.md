# Groupreads

The groupreads gem checks your list of to-read and read books against groups of
which you are a member and gives you a list of books to add to your to-read
list.

All data received from this gem comes from Goodreads. All data is available on
[Goodreads](https://www.goodreads.com).

A [demo](https://www.youtube.com/watch?v=svPbcjdBXr8&t=2s) is available [here](https://www.youtube.com/watch?v=svPbcjdBXr8&t=2s).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'groupreads'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install groupreads

## Usage

### Setup
Before using this library, you must get a
[Goodreads developer key](https://www.goodreads.com/api/keys). You will then
need to add your developer key as an environment variable.
```bash
export GOODREADS_KEY=QWjdksqSLKDSAKd
```
To continue using this gem, add this above line to the end of your
.bash_profile

To install this gem onto your local machine, run `bundle exec rake install`.

### Add yourself as a user
Run `groupreads register USER`. An example of this is
```bash
groupreads register 26040396-robert-hughes
>> robert-hughes added.
```

### List groups the user is a member of
Run `groupreads listgroups`
The output will be a list of books, one per line, such as:
> 114317-suffolk-bookclub

### List new group books to read
Run `groupreads newbooks`
The output should contain your new books to add in the form:
> Your new books are:
>  Ninja's and Elephants
>  The Secret World of the Cheesecake
You will then have the option of viewing more details on an individual book.

### Interactive mode
Run `groupreads interactive`
You will be provided with an interactive prompt for the above commands.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bundle exec cucumber features` to run the features, or
`bundle exec rspec spec` to run the specs. You can also run `bin/console` for
an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/safuya/groupreads. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Groupreads project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/safuya/groupreads/blob/master/CODE_OF_CONDUCT.md).
