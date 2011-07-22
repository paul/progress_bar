require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar write_every output' do
  before do
    @progress_bar = ProgressBar.new(100)
    @progress_bar.stub(:write) { false } # We don't care about the output
  end

  it "should call write 100 times when invoked 100 times by default" do
    @progress_bar.should_receive(:write).exactly(100).times
    1.upto(100) do
      @progress_bar.increment!
    end
  end

  it "should only call write 10 times when invoked 100 times, but told to write every 10 times" do
    @progress_bar.options[:write_every] = 10
    @progress_bar.should_receive(:write).exactly(10).times
    1.upto(100) do
      @progress_bar.increment!
    end
  end


end

