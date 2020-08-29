# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "ProgressBar counter output" do
  let(:progress_bar) { ProgressBar.new(100, :counter) }

  subject { progress_bar.to_s }

  describe "at count=0" do
    before do
      progress_bar.count = 0
    end

    it { should == "[  0/100]" }
  end

  describe "at count=50" do
    before do
      progress_bar.count = 50
    end

    it { should == "[ 50/100]" }
  end

  describe "at count=100" do
    before do
      progress_bar.count = 100
    end

    it { should == "[100/100]" }
  end

  describe "with a shorter max" do
    let(:progress_bar) { ProgressBar.new(42, :counter) }

    it { should == "[ 0/42]" }
  end

  describe "with a longer max" do
    let(:progress_bar) { ProgressBar.new(4242, :counter) }

    it { should == "[   0/4242]" }
  end
end
