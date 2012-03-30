module ProgressBar
  class NonTTY < Base
    def initialize(*args)
      super *args
    end

    protected

    def terminal_width
      100
    end

    def write
      print to_s
    end

    def print(str)
      puts str
    end
  end
end
