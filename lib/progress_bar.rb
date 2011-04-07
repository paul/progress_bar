
require 'options'
require 'highline'

require File.join(File.dirname(__FILE__), 'progress_bar', 'time_formatter')
require File.join(File.dirname(__FILE__), 'progress_bar', 'meter')
require File.join(File.dirname(__FILE__), 'progress_bar', 'meters')

class ProgressBar

  attr_accessor :count, :max, :start

  def initialize *args, &block
    args, options = Options.parse args

    @count = options[:count] || 0
    @max = options[:max] || 100
    @start = Time.now

    @hl = HighLine.new
  end

  def increment!
    self.count = count.succ
    write
  end

  def write
    clear!
    print to_s
  end

  def bar(width = terminal_width)
    Bar.new(count, max, width)
  end

  def counter
    Counter.new(count, max)
  end

  def percentage
    Percentage.new(count, max)
  end

  def elapsed
    Elapsed.new(start)
  end

  def eta
    ETA.new(start, count, max)
  end

  def to_s
    width = terminal_width -
              (counter.width + 1) -
              (percentage.width + 1) -
              (elapsed.width + 1) -
              (eta.width + 1)
    "#{bar(width)} #{counter} #{percentage} #{elapsed} #{eta}"
  end

  protected

  def clear!
    print "\r"
  end

  def terminal_width
    @hl.output_cols.to_i
  end

end
