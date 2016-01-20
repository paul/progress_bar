
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib/progress_bar/enumerable'))

p (20...34).with_progress.select{|i| sleep 0.1; (i % 2).zero?}
