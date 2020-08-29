# frozen_string_literal: true

require_relative "../lib/progress_bar"

bar = ProgressBar.new

100.times do
  sleep 0.1
  bar.increment!
end
