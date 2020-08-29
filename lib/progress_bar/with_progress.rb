# frozen_string_literal: true

class ProgressBar
  module WithProgress
    def each_with_progress(*args, &block)
      bar = ProgressBar.new(count, *args)
      if block
        each{ |obj| yield(obj).tap{ bar.increment! } }
      else
        Enumerator.new{ |yielder|
          each do |obj|
            (yielder << obj).tap{ bar.increment! }
          end
        }
      end
    end

    alias_method :with_progress, :each_with_progress
  end
end
