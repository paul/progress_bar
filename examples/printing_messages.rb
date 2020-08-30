# frozen_string_literal: true

require_relative "../lib/progress_bar"

bar = ProgressBar.new

100.times do |i|
  sleep 0.1
  bar.puts("Some long text\nthat contains newlines") if i == 10
  bar.puts("Halfway there!") if i == 50
  bar.puts("Almost done!") if i == 90
  bar.increment!
end

__END__

$ ruby examples/printing_messages.rb
Some long text
that contains newlines
Halfway there!
Almost done!
[##################################] [100/100] [100%] [00:10] [00:00] [  9.98/s]
