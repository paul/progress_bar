
require 'options'
require 'progress_bar/base'
require 'progress_bar/tty'

module ProgressBar
  def self.new(*args)
    ProgressBar::TTY.new(*args)
  end
end
