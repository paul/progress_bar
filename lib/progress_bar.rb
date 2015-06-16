
require 'highline'

class ProgressBar
  Error = Class.new(StandardError)
  ArgumentError = Class.new(Error)

  attr_accessor :title, :count, :max, :meters

  # Usage:
  #
  #   ProgressBar.new [ title=nil, ] [ max=100, ] [ *meters=:title, :bar, :counter, :percentage, :elapsed, :eta, :rate ]
  #
  # Example:
  #
  #   bar = ProgressBar.new # No title, 100 max count, all meters on.
  #   bar = ProgressBar.new 'foo.tar.bz2', 256 # With title, 256 max count, all meters on.
  #   bar = ProgressBar.new 200, :percentage # No title, 200 max count, :percentage meter only.
  #
  def initialize(*args)

    # Defaults.
    @title = nil
    @count = 0
    @max = 100
    @meters = [:title, :bar, :counter, :percentage, :elapsed, :eta, :rate]

    @title = args.shift if args.first.is_a? String
    @max = args.shift if args.first.is_a? Numeric
    raise ArgumentError, "Max must be a positive integer" unless @max > 0

    @meters = args unless args.empty?

    @last_write = ::Time.at(0)
    @start = ::Time.now

    @hl = HighLine.new
  end

  def increment!(count = 1)
    self.count += count
    now = ::Time.now
    if (now - @last_write) > 0.2 || self.count >= max
      write
      @last_write = now
    end
  end

  def write
    carriage_return!
    print to_s
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
    meters
      .map { |meter| render(meter) }
      .reject { |rendered_meter| rendered_meter.nil? }
      .join ' '
  end

  def clear!
    print "\r#{' ' * terminal_width}\r"
  end

  protected

  def carriage_return!
    print "\r"
  end

  def print(str)
    $stderr.write str
  end

  def render(meter)
    send(:"render_#{meter}")
  end

  def width_of(meter)
    send(:"#{meter}_width")
  end

  def render_title
    "[#{title}]" if title
  end

  def render_bar
    return '' if bar_width < 2
    "[" +
      "#" * (ratio * (bar_width - 2)).ceil +
      " " * ((1-ratio) * (bar_width - 2)).floor +
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
    if @terminal_width.nil? || @last_width_adjustment.nil? ||
                               ::Time.now - @last_width_adjustment > 1

      @last_width_adjustment = ::Time.now
      @terminal_width = @hl.output_cols.to_i
      if @terminal_width < 1
        @terminal_width = 80
      end
      @terminal_width
    else
      @terminal_width
    end
  end

  def title_width
    if title
      title.size + 2
    else
      0
    end
  end

  def bar_width
    terminal_width - non_bar_width
  end

  def non_bar_width
    meters
      .reject { |meter| meter == :bar }
      .map { |meter| width_of(meter) }
      .select { |meter_width| meter_width > 0 }
      .inject(0) { |width, meter_width| width += meter_width + 1 }
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
