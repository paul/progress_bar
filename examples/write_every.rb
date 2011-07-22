
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib/progress_bar'))

bar = ProgressBar.new(105, :write_every => 10)

105.times do
  sleep 0.1
  bar.increment!
end
