require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar bar output' do
  before do
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
    @progress_bar = ProgressBar.new(100)
    allow(@progress_bar).to receive(:terminal_width) { 60 }
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { is_expected.to eq("[              ] [  0/100] [  0%] [00:10] [00:00] [  0.00/s]") }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { is_expected.to eq("[#######       ] [ 50/100] [ 50%] [00:10] [00:10] [  5.00/s]") }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { is_expected.to eq("[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]") }
  end

  describe 'at count=105' do
    before do
      @progress_bar.count = 105
    end

    it { is_expected.to eq("[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]") }
  end

end


