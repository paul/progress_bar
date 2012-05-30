module ProgressBar
  class NonTTY < Base
    def initialize(*args)
      super *args
    end

    protected

    def default_update_frequency
      2 # seconds
    end

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
