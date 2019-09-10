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

  it 'should allow specifying the style as a string' do
    bar = ProgressBar.new(style: 'green')
    bar.style.should == 32
  end

  it 'should allow specifying the style as a symbol' do
    bar = ProgressBar.new(style: :green)
    bar.style.should == 32
  end

  it 'should allow specifying the style as a integer' do
    bar = ProgressBar.new(style: 32)
    bar.style.should == 32
  end

  it "should raise an error when initial max is nonsense" do
    lambda {
      bar = ProgressBar.new(-1)
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when style is invalid' do
    lambda {
      _bar = ProgressBar.new(style: 'magic_rainbow')
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when style is empty' do
    lambda {
      _bar = ProgressBar.new(style: '')
    }.should raise_error(ProgressBar::ArgumentError)
  end
end
