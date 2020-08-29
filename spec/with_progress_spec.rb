# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe ProgressBar::WithProgress do
  context "with block" do
    let!(:bar){ ProgressBar.new }

    before{
      Range.include ProgressBar::WithProgress
      allow(ProgressBar).to receive(:new){ |max| bar.max = max; bar }
    }

    it "should set max and increment on each iteration" do
      (1..20).each_with_progress do |i|
        break if i > 10
      end
      expect(bar.max).to eq 20
      expect(bar.count).to eq 10
    end
  end

  context "without block" do
    let!(:bar){ ProgressBar.new }

    before{
      Range.include ProgressBar::WithProgress
      allow(ProgressBar).to receive(:new){ |max| bar.max = max; bar }
    }

    it "should give Enumerator" do
      enum = (1..20).each_with_progress
      expect(enum).to be_kind_of(Enumerator)
      expect(bar.max).to eq 20
      expect(bar.count).to eq 0

      res = enum.map{ |i| i + 1 }
      expect(res).to eq (2..21).to_a
      expect(bar.count).to eq 20
    end
  end
end
