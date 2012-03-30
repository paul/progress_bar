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

  def self.tty?
    $stdout.isatty
  end
end
