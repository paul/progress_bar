require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar rate output' do
  before do
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
    @progress_bar = ProgressBar.new(100, :rate)
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { should == "[  0.00/s]" }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { should == "[  5.00/s]" }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { should == "[ 10.00/s]" }
  end

  describe 'with a shorter max' do
    before do
      Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
      @progress_bar = ProgressBar.new(42, :rate)
      @progress_bar.count = 21
      Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
    end

    it { should == '[ 2.10/s]' }
  end

  describe 'with a longer max' do
    before do
      Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
      @progress_bar = ProgressBar.new(4242, :rate)
      @progress_bar.count = 21
      Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
    end

    it { should == '[   2.10/s]' }
  end

end





