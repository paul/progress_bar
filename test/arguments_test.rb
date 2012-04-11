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

end

