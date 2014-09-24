require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar counter output' do
  before do
    @progress_bar = ProgressBar.new(100, :counter)
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { is_expected.to eq("[  0/100]") }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { is_expected.to eq("[ 50/100]") }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { is_expected.to eq("[100/100]") }
  end

  describe 'with a shorter max' do
    before do
      @progress_bar = ProgressBar.new(42, :counter)
    end

    it { is_expected.to eq('[ 0/42]') }
  end

  describe 'with a longer max' do
    before do
      @progress_bar = ProgressBar.new(4242, :counter)
    end

    it { is_expected.to eq('[   0/4242]') }
  end

end
