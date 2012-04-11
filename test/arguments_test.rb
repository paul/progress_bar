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

  it "should allow specifying the max" do
    bar = ProgressBar.new(max: 123)
    bar.max.should == 123
    bar.meters.should == @default_meters
  end

  it "should allow specifying just the meters" do
    bar = ProgressBar.new(meters: [:bar, :eta])
    bar.max.should == @default_max
    bar.meters.should == [:bar, :eta]
  end

  it "should allow specyfing the max and meters" do
    bar = ProgressBar.new(max: 123, meters: [:bar, :eta])
    bar.max.should == 123
    bar.meters.should == [:bar, :eta]
  end

  it "should allow specyfing the format" do
    test_format = ["O", "o"]
    bar = ProgressBar.new(format: test_format)
    bar.format.should == test_format
  end

  it "should raise error if the max is not a Number" do
    lambda {
      bar = ProgressBar.new(max: 'text')
    }.should raise_error('Max must be a Numeric')
  end

  it "should raise error if the format is more than 1 char long" do
    lambda {
      bar = ProgressBar.new(format: ["++", "--"])
    }.should raise_error('Format string not correct size, please use 1 char')
  end

  it "should raise error if the format is less than 1 char long" do
    lambda {
      bar = ProgressBar.new(format: ["*", ""])
    }.should raise_error('Format string not correct size, please use 1 char')
  end
end

