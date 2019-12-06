require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar arguments' do
  before do
    @default_max = 100
    @default_meters = [:bar, :counter, :percentage, :elapsed, :eta, :rate]
  end

  it 'should set appropriate defaults without any arguments' do
    bar = ProgressBar.new
    bar.max.should == @default_max
    bar.meters.should == @default_meters
  end

  it 'should allow a single argument specifying the max' do
    bar = ProgressBar.new(123)
    bar.max.should == 123
    bar.meters.should == @default_meters
  end

  it 'should allow specifying just the meters' do
    bar = ProgressBar.new(:bar, :eta)
    bar.max.should == @default_max
    bar.meters.should == [:bar, :eta]
  end

  it 'should allow specifying the max and meters' do
    bar = ProgressBar.new(123, :bar, :eta)
    bar.max.should == 123
    bar.meters.should == [:bar, :eta]
  end

  it 'should allow specifying the bar and delimiters' do
    bar = ProgressBar.new(bar: '$', delimiters: '||')
    bar.bar.should == '$'
    bar.delimiters.should == '||'
  end

  it 'should raise an error when initial max is nonsense' do
    lambda {
      _bar = ProgressBar.new(-1)
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when bar is not a string' do
    lambda {
      _bar = ProgressBar.new(bar: 5)
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when bar is empty' do
    lambda {
      _bar = ProgressBar.new(bar: nil)
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when delimiters is less than two characters' do
    lambda {
      _bar = ProgressBar.new(delimiters: '|')
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when delimiters is more than two characters' do
    lambda {
      _bar = ProgressBar.new(delimiters: '|||')
    }.should raise_error(ProgressBar::ArgumentError)
  end

  it 'should raise an error when delimiters is empty' do
    lambda {
      _bar = ProgressBar.new(delimiters: '')
    }.should raise_error(ProgressBar::ArgumentError)
  end
end
