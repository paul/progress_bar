class ProgressBar
  class ETA < Meter

    include TimeFormatter

    attr_reader :start, :count, :max

    def initialize start, count, max
      @start, @count, @max = start, count, max
    end

    def elapsed
      Time.now - start
    end

    def average
      if count == 0
        0
      else
        elapsed / count
      end
    end

    def remaining
      (max - count) * average
    end

    def to_s
      "[ETA: #{format_interval(remaining)}]"
    end

    def width
      format_interval(elapsed).length + 7
    end
  end
end
