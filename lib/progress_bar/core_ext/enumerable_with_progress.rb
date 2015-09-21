require_relative '../../progress_bar'

# FIXME: should there be a better method?..
[Enumerable, Array, Hash, Range].each do |mod|
  mod.send :include, ProgressBar::WithProgress
end
