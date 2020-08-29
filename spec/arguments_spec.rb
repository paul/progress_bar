# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "ProgressBar arguments" do
  let(:default_max) { 100 }
  let(:default_meters) { [:bar, :counter, :percentage, :elapsed, :eta, :rate] }

  it "should set appropriate defaults without any arguments" do
    bar = ProgressBar.new
    expect(bar.max).to eq default_max
    expect(bar.meters).to eq default_meters
  end

  it "should allow a single argument specifying the max" do
    bar = ProgressBar.new(123)
    expect(bar.max).to eq 123
    expect(bar.meters).to eq default_meters
  end

  it "should allow specifying just the meters" do
    bar = ProgressBar.new(:bar, :eta)
    expect(bar.max).to eq default_max
    expect(bar.meters).to eq [:bar, :eta]
  end

  it "should allow specyfing the max and meters" do
    bar = ProgressBar.new(123, :bar, :eta)
    expect(bar.max).to eq 123
    expect(bar.meters).to eq [:bar, :eta]
  end

  it "should raise an error when initial max is nonsense" do
    expect { ProgressBar.new(-1) }
      .to raise_error(ProgressBar::ArgumentError)
  end
end
