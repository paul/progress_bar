
class ProgressBar
  class Bar < Meter

    attr_reader :count, :max, :width

    def initialize(count, max, width)
      @count, @max, @width = count, max, width
    end

    def to_s
      "[" +
        "#" * progress_width +
        " " * remaining_width +
      "]"
    end

    def bar_width
      width - 2
    end

    def progress_width
      ((count.to_f / max) * bar_width).ceil
    end

    def remaining_width
      bar_width - progress_width
    end

  end
end
