# ProgressBar

[![Build Status](https://github.com/paul/progress_bar/workflows/Test/badge.svg)](https://github.com/paul/progress_bar/actions)[![Gem Version](https://badge.fury.io/rb/progress_bar.svg)](http://badge.fury.io/rb/progress_bar)

*ProgressBar* is a simple Ruby library for displaying progress of
long-running tasks on the console. It is intended to be as simple to use
as possible.

**NOTE:** This project isn't dead! It's just feature complete, and I don't want
to keep adding things to it. If you find bugs, please open an Issue, or even
better, a Pull Request, and I'll take a look. We at ProgressBar know you have
lots of progress bar alternatives, and we thank you for using ProgressBar!


# Installation

    gem install progress_bar

# Examples

## The Easy Way

```ruby
require 'progress_bar'

bar = ProgressBar.new

100.times do
  sleep 0.1
  bar.increment!
end
```

Produces output like:

    [#######################################                           ] [ 59.00%] [00:06]

*Note: It may not be exactly like this. I might have changed the default
meters between now and when I wrote this readme, and forgotten to update
it.*

## Setting the Max

Usually, the defaults should be fine, the only thing you'll need to
tweak is the max.

```ruby
bar = ProgressBar.new(1000)
```

## Larger Steps

If you want to process several things, and update less often, you can
pass a number to `#increment!`

```ruby
    bar.increment! 42
```

## Printing additional output

Sometimes you want to print some additional messages in the output, but since the ProgressBar uses terminal control characters to replace the text on the same line on every update, the output looks funny:

    [#######################################                           ] [ 59.00%] [00:06]
    Hello!
    [#########################################                         ] [ 60.00%] [00:05]

To prevent this, you can use `ProgressBar#puts` so ProgressBar knows you want to print something, and it'll clear the bar before printing, then resume printing on the next line:

```ruby
100.times do |i|
  sleep 0.1
  bar.puts "Halfway there!" if i == 50
  bar.increment!
end
```

Produces output like:

    Halfway there!
    [##################################] [100/100] [100%] [00:10] [00:00] [  9.98/s]

Try it out in `examples/printing_messages.rb` to see how it looks.

## Picking the meters

By default, ProgressBar will use all available meters (this will
probably change). To select which meters you want, and in which order,
pass them to the constructor:

```ruby
bar = ProgressBar.new(100, :bar, :rate, :eta)
```


### Available Meters

 * `:bar` -- The bar itself, fills empty space with "#"s. Ex: `[###
   ]`.
 * `:counter` -- Number of items complete, over the max. Ex: `[ 20/100]`
 * `:percentage` -- Percentage of items in the maximum. Ex: `[ 42%]`
 * `:elapsed` -- Time elapsed (since the ProgressBar was initialized.
   Ex: `[00:42]`
 * `:eta` -- Estimated Time remaining. Given the rate that items are
   completed, a guess at how long the rest will take. Ex: `[01:30]`
 * `:rate` -- The rate at which items are being completed. Ex: `[
   42.42/s]`

Run the tests to see examples of all the formats, with different values
and maximums.
```
gem install --development progress_bar
rspec spec/*_spec.rb
```

## Using ProgressBar on Enumerable-alikes.

If you do a lot of progresses, you can shorten your way with this:

```ruby
class Array
  include ProgressBar::WithProgress
end

[1,2,3].each_with_progress{do_something}

# or any other Enumerable's methods:

(1..1000).to_a.with_progress.select{|i| (i % 2).zero?}
```

You can include `ProgressBar::WithProgress` in any class, having methods
`#count` and `#each`, like some DB datasets and so on.

If you are using progress_bar regularly on plain arrays, you may want to
do:

```ruby
require 'progress_bar/core_ext/enumerable_with_progress'

# it adds each_with_progress/with_progress to Array/Hash/Range

(1..400).with_progress.select{|i| (i % 2).zero?}
```

If you want to display only specific meters you can do it like so:

```ruby
(1..400).with_progress(:bar, :elapsed).select{|i| (i % 2).zero?}
```
