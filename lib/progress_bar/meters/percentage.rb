
class ProgressBar
  class Percentage < Meter

    attr_reader :count, :max

    def initialize count, max
      @count, @max = count, max
    end

    def to_s
      "[%6.2f%%]" % (count.to_f / max * 100)
    end

    def width
      9
    end

  end
end
