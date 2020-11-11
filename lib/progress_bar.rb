# frozen_string_literal: true

require "options"
require "highline"

class ProgressBar
  Error = Class.new(StandardError)
  ArgumentError = Class.new(Error)

  attr_accessor :count, :max, :meters

  def initialize(*args)
    @count      = 0
    @max        = 100
    @meters     = [:bar, :counter, :percentage, :elapsed, :eta, :rate]

    @max = args.shift if args.first.is_a? Numeric
    raise ArgumentError, "Max must be a positive integer" unless @max >= 0

    @meters = args unless args.empty?

    @last_write = ::Time.at(0)
    @start      = ::Time.now

    @hl = HighLine.new
    @terminal_width = 80
    @last_width_adjustment = ::Time.at(0)
  end

  def increment!(count = 1)
    @count += count
    now = ::Time.now
    if (now - @last_write) > 0.2 || @count >= max
      write
      @last_write = now
    end
  end

  def puts(text)
    clear!
    $stderr.write(text)
    $stderr.puts
    write
  end

  def write
    print "\r" + to_s
  end

  def remaining
    max - count
  end

  def ratio
    [count.to_f / max, 1.0].min # never go above 1, even if count > max
  end

  def percentage
    ratio * 100
  end

  def elapsed
    ::Time.now - @start
  end

  def rate
    if count > 0
      count / elapsed
    else
      0
    end
  end

  def eta
    if count > 0
      remaining / rate
    else
      0
    end
  end

  def to_s
    self.count = max if count > max
    meters.inject(String.new) do |text, meter|
      text << "#{render(meter)} "
    end.strip
  end

  protected

  def print(str)
    $stderr.write str
  end

  def clear!
    print "\r" + " " * terminal_width + "\r"
  end

  def render(meter)
    send(:"render_#{meter}")
  end

  def width_of(meter)
    send(:"#{meter}_width")
  end

  def render_bar
    return "" if bar_width < 2

    progress_width = (ratio * (bar_width - 2)).floor
    remainder_width = bar_width - 2 - progress_width
    "[#{'#' * progress_width}#{' ' * remainder_width}]"
  end

  def render_counter
    "[%#{max_width}i/%i]" % [count, max]
  end

  def render_percentage
    format = (max == 100 ? "%3i" : "%6.2f")
    "[#{format}%%]" % percentage
  end

  def render_elapsed
    "[#{format_interval(elapsed)}]"
  end

  def render_eta
    "[#{format_interval(eta)}]"
  end

  def render_rate
    "[%#{max_width + 3}.2f/s]" % rate
  end

  def terminal_width
    # HighLine check takes a long time, so only update width every second.
    now = ::Time.now
    if now - @last_width_adjustment > 1
      @last_width_adjustment = now
      new_width = @hl.output_cols.to_i
      new_width = 80 if new_width < 1
      @terminal_width = new_width
    else
      @terminal_width
    end
  end

  def bar_width
    terminal_width - non_bar_width
  end

  def non_bar_width
    meters.reject { |meter| meter == :bar }.inject(0) do |width, meter|
      width += width_of(meter) + 1
    end
  end

  def counter_width # [  1/100]
    max_width * 2 + 3
  end

  def percentage_width
    if max == 100      # [ 24%]
      6
    else               # [ 24.00%]
      9
    end
  end

  def elapsed_width
    format_interval(elapsed).length + 2
  end

  def eta_width
    format_interval(eta).length + 2
  end

  def rate_width     # [ 23.45/s]
    render_rate.length
  end

  def max_width
    max.to_s.length
  end

  HOUR = 3600
  MINUTE = 60
  def format_interval(interval)
    if interval > HOUR
      "%02i:%02i:%02i" % [interval / HOUR, interval % HOUR / MINUTE, interval % MINUTE]
    else
      "%02i:%02i" % [interval / MINUTE, interval % MINUTE]
    end
  end
end

require_relative "progress_bar/with_progress"
