# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "ProgressBar bar output" do
  let(:max) { 100 }
  let(:terminal_width) { 12 }

  let(:progress_bar) { ProgressBar.new(max, :bar) }

  before do
    allow(progress_bar).to receive(:terminal_width).and_return(terminal_width)
    progress_bar.count = count
  end

  subject { progress_bar.to_s }

  describe "at count=0" do
    let(:count) { 0 }

    it { should == "[          ]" }
  end

  describe "at count=50" do
    let(:count) { 50 }

    it { should == "[#####     ]" }
  end

  describe "at count=100" do
    let(:count) { 100 }

    it { should == "[##########]" }
  end

  describe "at count=25 (non-integer divide, should round down)" do
    let(:count) { 25 }

    it { should == "[##        ]" }
  end

  # https://github.com/paul/progress_bar/pull/31
  describe "constant bar width" do
    let(:max)            { 17 }
    let(:count)          {  0 }
    let(:terminal_width) { 80 }

    it "has a constant bar width for all values of max and count" do
      (count..max).each do |i|
        progress_bar.count = i
        expect( progress_bar.to_s.length ).to eq(80)
      end
    end
  end
end
