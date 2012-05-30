require 'options'

$LOAD_PATH << 'lib'
require 'progress_bar/base'
require 'progress_bar/tty'
require 'progress_bar/non_tty'

module ProgressBar
  def self.new(*args)
    if tty?
      ProgressBar::TTY.new(*args)
    else
      ProgressBar::NonTTY.new(*args)
    end
  end

  # Force one behaviour by setting this env variable one way or another.
  #
  # PROGRESS_BAR_FORCE=tty
  # PROGRESS_BAR_FORCE=non_tty
  def self.tty?
    if forced_mode = ENV['PROGRESS_BAR_FORCE']
      return false  if forced_mode =~ /non.?tty/i
      return true   if forced_mode =~ /tty/i
      raise ArgumentError, "Invalid value for env var PROGRESS_BAR_FORCE=#{
                            forced_mode}. Acceptable: non_tty or tty."
    else
      $stdout.isatty
    end
  end
end
