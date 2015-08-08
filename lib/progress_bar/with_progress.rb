class ProgressBar
  module WithProgress
    def each_with_progress(&block)
      bar = ProgressBar.new(count)
      if block
        each{|obj| yield(obj).tap{bar.increment!}}
      else
        Enumerator.new{|yielder|
          self.each do |obj|
            (yielder << obj).tap{bar.increment!}
          end
        }
      end
    end

    alias_method :with_progress, :each_with_progress
  end
end
