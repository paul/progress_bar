
require 'options'
require 'highline'

class ProgressBar

  attr_accessor :count, :max, :meters, :format
  METERS = [:bar, :counter, :percentage, :elapsed, :eta, :rate]

  def initialize(args = {})

    @count      = 0
    @max        = 100
    @meters     = METERS
    @format     = ["#", " "]

    @max        = args[:max] if args.has_key? :max
    @meters     = args[:meters] if args.has_key? :meters
    @format     = args[:format] if args.has_key? :format

    raise 'Max must be a Numeric' unless @max.is_a? Numeric
    @meters.each do |m|
      raise 'Meter name given is not a valid type' unless METERS.include? m
    end
    raise 'Format param must be an array of two elements' unless @format.size == 2
    @format.each do |f|
      raise 'Format string not correct size, please use 1 char' unless f.size == 1
    end

    @last_write = Time.at(0)
    @start      = Time.now

    @hl         = HighLine.new
  end

  def increment!(count = 1)
    self.count += count
    now = Time.now
    if (now - @last_write) > 0.2 || self.count >= max
      write
      @last_write = now
    end
  end

  def write
    clear!
    print to_s
  end

  def remaining
    max - count
  end

  def ratio
    count.to_f / max
  end

  def percentage
    ratio * 100
  end

  def elapsed
    Time.now - @start
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
    meters.inject("") do |text, meter|
      text << render(meter) + " "
    end.strip
  end

  protected

  def print(str)
    $stderr.write str
  end

  def clear!
    print "\r"
  end

  def render(meter)
    send(:"render_#{meter}")
  end

  def width_of(meter)
    send(:"#{meter}_width")
  end

  def render_bar
    "[" +
      @format[0] * (ratio * (bar_width - 2)).ceil +
      @format[1] * ((1-ratio) * (bar_width - 2)).floor +
    "]"
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
    "[%#{max_width+3}.2f/s]" % rate
  end

  def terminal_width
    # HighLine check takes a long time, so only update width every second.
    if @last_width_adjustment.nil? || Time.now - @last_width_adjustment > 1
      @last_width_adjustment = Time.now
      @terminal_width = @hl.output_cols.to_i
    else
      @terminal_width
    end
  end

  def bar_width
    terminal_width - non_bar_width
  end

  def non_bar_width
    meters.reject { |m| m == :bar }.inject(0) do |width, meter|
      width += width_of(meter) + 1
    end
  end

  def counter_width   # [  1/100]
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

  def format_interval(interval)
    if interval > 3600
      "%02i:%02i:%02i" % [interval/3600, interval%3600/60, interval%60]
    else
      "%02i:%02i" % [interval/60, interval%60]
    end
  end

end
