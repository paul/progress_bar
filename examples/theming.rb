# frozen_string_literal: true

require "paint"

require_relative "../lib/progress_bar"

CAT = "🐱"
# RAINBOW = "🏳️‍🌈"
RAINBOW = "🌈"

def self.rainbow(ratio)
  blue  = Math.sin(ratio + 0) * 127 + 128
  red   = Math.sin(ratio + 2 * Math::PI / 3) * 127 + 128
  green = Math.sin(ratio + 4 * Math::PI / 3) * 127 + 128
  "#%02X%02X%02X" % [red, green, blue]
end

theme = ProgressBar::Theme.new(
  line_prefix: ->(bar, **) {
    color = rainbow(bar.ratio * 6)
    Paint.color(color)
  },
  bar_element: ->(bar, pos:, width:) {
    if pos + bar.display_width(CAT) >= width
      CAT
    else
      RAINBOW
    end
  }
)

bar = ProgressBar.new(100, theme: theme)

100.times do
  bar.increment!
  sleep 0.1
end
