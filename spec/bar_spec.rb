require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar bar output' do
  before do
    @progress_bar = ProgressBar.new(100, :bar)
    allow(@progress_bar).to receive(:terminal_width) { 12 }
  end

  subject { @progress_bar.to_s }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0
    end

    it { is_expected.to eq("[          ]") }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50
    end

    it { is_expected.to eq("[#####     ]") }
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100
    end

    it { is_expected.to eq("[##########]") }
  end

  describe 'at count=25 (non-integer divide, should round up)' do
    before do
      @progress_bar.count = 25
    end

    it { is_expected.to eq("[###       ]") }
  end

end

