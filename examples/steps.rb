
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib/progress_bar'))

steps = [ 'foo.tar.gz2', 'bar.zip', 'baz.mp3' ]

bar = ProgressBar.new

steps.each_with_index do |name, i|
  bar.count = 0
  bar.title = "#{i+1}/#{steps.size} #{name}"
  100.times do
    sleep 0.05
    bar.increment!
  end
end

# Clear progress bar.
bar.clear!
