require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'The ProgressBar factory' do
  it 'should instantiate the TTY class if stdout is a terminal' do
    ProgressBar.stub(:tty?).and_return(true)
    ProgressBar::TTY.should_receive(:new)
    ProgressBar.new
  end

  it 'should instantiate the NonTTY class if stdout is not a terminal' do
    ProgressBar.stub(:tty?).and_return(false)
    ProgressBar::NonTTY.should_receive(:new)
    ProgressBar.new
  end

  context 'the env variable PROGRESS_BAR_FORCE' do
    after do
      ENV['PROGRESS_BAR_FORCE'] = nil
    end

    it "lets one force the tty behaviour with a non_tty stdout" do
      $stdout.stub(:isatty).and_return(false)
      ENV['PROGRESS_BAR_FORCE'] = 'tty'
      ProgressBar::TTY.should_receive(:new)
      ProgressBar.new
    end

    it "lets one force the non_tty behaviour with a tty stdout" do
      $stdout.stub(:isatty).and_return(true)
      ENV['PROGRESS_BAR_FORCE'] = 'non_tty'
      ProgressBar::NonTTY.should_receive(:new)
      ProgressBar.new
    end

    it "must be set properly" do
      ENV['PROGRESS_BAR_FORCE'] = 'true'
      expect { ProgressBar.new }.to raise_error(ArgumentError, /tty/)
    end
  end
end
