require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe ProgressBar::Styles do
  context 'with style' do
    let!(:bar){ ProgressBar.new(style: :blue) }

    it 'should return to_s with formatting' do
      bar.to_s == "\e[#{34}m#{"[              ] [  0/100] [  0%] [00:10] [00:00] [  0.00/s]"}\e[0m"
    end
  end

  context 'without style' do
    let!(:bar){ ProgressBar.new }

    it 'should return to_s without formatting' do
      bar.to_s == "[              ] [  0/100] [  0%] [00:10] [00:00] [  0.00/s]"
    end
  end
end
