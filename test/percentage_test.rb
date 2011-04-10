require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar percentage output' do
  before do
    @progress_bar = ProgressBar.new(100, :percentage)
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { should == "[  0%]" }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { should == "[ 50%]" }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { should == "[100%]" }
  end

  describe 'with a max that is not 100' do
    before do
      @progress_bar = ProgressBar.new(42, :percentage)
      @progress_bar.count = 21
    end

    it { should == '[ 50.00%]' }
  end

end

