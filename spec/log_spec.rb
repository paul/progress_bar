require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar bar log output' do
  before do
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
    @progress_bar = ProgressBar.new(100)
    @progress_bar.stub(:terminal_width) { 60 }
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later

    @message = "The ships hung in the sky in much the same way that bricks don't."
    @expected_gap = "     " # this is the computed gap based on the terminal_width and bar
  end

  subject { @progress_bar.log_s(@message) }

  describe 'at count=0' do
    before do
      @progress_bar.count = 0

      @expected_s = "The ships hung in the sky in much the same way that bricks don't." +
        @expected_gap +
        "\n[              ] [  0/100] [  0%] [00:10] [00:00] [  0.00/s]"
    end

    it { should == @expected_s }
  end

  describe 'at count=50' do
    before do
      @progress_bar.count = 50

      @expected_s = "The ships hung in the sky in much the same way that bricks don't." +
        @expected_gap +
        "\n[#######       ] [ 50/100] [ 50%] [00:10] [00:10] [  5.00/s]"
    end

    it { should ==  @expected_s}
  end

  describe 'at count=100' do
    before do
      @progress_bar.count = 100

      @expected_s = "The ships hung in the sky in much the same way that bricks don't." +
        @expected_gap +
        "\n[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]"
    end

    it { should == @expected_s}
  end

  describe 'at count=105' do
    before do
      @progress_bar.count = 105

      @expected_s = "The ships hung in the sky in much the same way that bricks don't." +
        @expected_gap +
        "\n[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]"
    end

    it { should == @expected_s}
  end
end
