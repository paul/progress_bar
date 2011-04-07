
class ProgressBar
  class Counter < Meter

    attr_reader :count, :max

    def initialize(count, max)
      @count, @max = count, max
    end

    def to_s
      "[%#{max_counter_width}i/%i]" % [count, max]
    end

    def width
      max.to_s.length * 2 + 3
    end

    def max_counter_width
      max.to_s.length
    end

  end
end
