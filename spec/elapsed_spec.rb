
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar elapsed output' do
  before do
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
    @progress_bar = ProgressBar.new(100, :elapsed)
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { should == "[00:10]" }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { should == "[00:10]" }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { should == "[00:10]" }
  end

  describe 'with times over 1 hour' do
    before do
      Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
      @progress_bar = ProgressBar.new(42, :elapsed)
      Timecop.freeze Time.utc(2010, 3, 10, 2, 0, 0) # 2 hours later
    end

    it { should == '[02:00:00]' }
  end

end

