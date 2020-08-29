# frozen_string_literal: true

require_relative "../../progress_bar"

ObjectSpace.each_object(Module) do |mod|
  if mod <= Enumerable
    mod.send :include, ProgressBar::WithProgress
  end
end
