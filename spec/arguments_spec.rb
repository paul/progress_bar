require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar arguments' do
  before do
    @default_max = 100
    @default_meters = [:bar, :counter, :percentage, :elapsed, :eta, :rate]
  end

  it "should set appropriate defaults without any arguments" do
    bar = ProgressBar.new
    bar.max.should == @default_max
    bar.meters.should == @default_meters
  end

  it "should allow a single argument specifying the max" do
    bar = ProgressBar.new(123)
    bar.max.should == 123
    bar.meters.should == @default_meters
  end

  it "should allow specifying just the meters" do
    bar = ProgressBar.new(:bar, :eta)
    bar.max.should == @default_max
    bar.meters.should == [:bar, :eta]
  end

  it "should allow specyfing the max and meters" do
    bar = ProgressBar.new(123, :bar, :eta)
    bar.max.should == 123
    bar.meters.should == [:bar, :eta]
  end

  it "should raise an error when initial max is nonsense" do
    lambda {
      bar = ProgressBar.new(0)
    }.should raise_error(ProgressBar::ArgumentError)
  end

end

