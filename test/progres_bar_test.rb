
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib/progress_bar'))

bar = ProgressBar.new

100.times do
  sleep 0.1
  bar.increment!
end
