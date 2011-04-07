class ProgressBar
  class Elapsed < Meter

    include TimeFormatter

    attr_reader :start

    def initialize start
      @start = start
    end

    def elapsed
      Time.now - start
    end

    def to_s
      "[#{format_interval(elapsed)}]"
    end

    def width
      format_interval(elapsed).length + 2
    end

  end
end

