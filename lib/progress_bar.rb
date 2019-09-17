# frozen_string_literal: true

require "options"
require "highline"
require "unicode/display_width"

class ProgressBar
  Error = Class.new(StandardError)
  ArgumentError = Class.new(Error)

  Theme = Struct.new(:bar_element,
                     :delimiter,
                     :open_delimiter,
                     :close_delimiter,
                     :line_prefix,
                     :line_suffix,
                     keyword_init: true) do
    def initialize(bar_element: "#", delimiter: ["[", "]"], line_prefix: "", line_suffix: "")
      super
    end

    def open_delimiter
      @open_delimiter ||= delimiter.is_a?(Array) ? delimiter.first : delimiter
    end

    def close_delimiter
      @close_delimiter ||= delimiter.is_a?(Array) ? delimiter.last : delimiter
    end
  end

  attr_accessor :count, :max, :meters, :theme

  DEFAULT_METERS = [:bar, :counter, :percentage, :elapsed, :eta, :rate].freeze
  DEFAULT_THEME = Theme.new(
    bar_element: "#",
    delimiter:   %w([ ])
  )

  def initialize(*args, theme: DEFAULT_THEME)
    @count  = 0
    @max    = args.first.is_a?(Integer) ? args.shift : 100
    @meters = args.empty? ? DEFAULT_METERS : args
    @theme  = theme

    raise ArgumentError, "Max must be a positive integer" unless @max >= 0

    @last_write = ::Time.at(0)
    @start      = ::Time.now

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
    clear!
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
    (theme.line_prefix.respond_to?(:call) ? theme.line_prefix.call(self) : theme.line_prefix) +
      meters.inject(String.new) do |text, meter|
        text << render(meter) + " "
      end.strip +
      theme.line_suffix
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

  def render_meter(content)
    theme.open_delimiter + content + theme.close_delimiter
  end

  def render_bar
    return "" if bar_width < 2

    progress_width = (ratio * (bar_width - 2)).floor
    bar = if theme.bar_element.respond_to?(:call)
            text = String.new
            length = 0
            until length >= progress_width
              text << theme.bar_element.call(self, length, progress_width, bar_width)
              length = Unicode::DisplayWidth.of(text)
            end
            text
          else
            theme.bar_element * progress_width
    end
    remainder_width = bar_width - 2 - Unicode::DisplayWidth.of(bar)
    render_meter(bar + " " * remainder_width)
  end

  def render_counter
    render_meter("%#{max_width}i/%i" % [count, max])
  end

  def render_percentage
    format = (max == 100 ? "%3i" : "%6.2f")
    render_meter("#{format}%%" % percentage)
  end

  def render_elapsed
    render_meter(format_interval(elapsed).to_s)
  end

  def render_eta
    render_meter(format_interval(eta).to_s)
  end

  def render_rate
    render_meter("%#{max_width + 3}.2f/s" % rate)
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

  def bar_width
    terminal_width - non_bar_width
  end

  def non_bar_width
    meters.reject { |m| m == :bar }.inject(0) do |width, meter|
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

  def rate_width # [ 23.45/s]
    render_rate.length
  end

  def max_width
    max.to_s.length
  end

  def format_interval(interval)
    if interval > 3600
      "%02i:%02i:%02i" % [interval / 3600, interval % 3600 / 60, interval % 60]
    else
      "%02i:%02i" % [interval / 60, interval % 60]
    end
  end
end

require_relative "progress_bar/with_progress"
