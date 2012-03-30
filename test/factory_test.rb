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
end
