module ProgressBar
  class TTY < Base
    def initialize(*args)
      require 'highline'
      super *args
      @hl = HighLine.new
    end

    def write
      clear!
      print to_s
    end

    protected

    def default_update_frequency
      0.2 # seconds
    end

    def print(str)
      $stderr.write str
    end

    def clear!
      print "\r"
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

  end
end

