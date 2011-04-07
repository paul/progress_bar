
class ProgressBar
  module TimeFormatter

    def format_interval(interval)
      if interval > 3600
        "%02i:%02i:%02i" % [interval/3600, interval%3600/60, interval%60]
      else
        "%02i:%02i" % [interval/60, interval%60]
      end
    end

  end
end

