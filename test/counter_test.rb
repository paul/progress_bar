require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

describe "Counter formatter" do
  before do
    @counter = ProgressBar::Counter.new(50, 100)
  end

  it 'should format properly' do
    @counter.to_s.must_equal "[ 50/100]"
  end

  it 'should have the correct width' do
    @counter.width.must_equal 9
  end
end
