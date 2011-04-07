require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

describe "ETA formatter" do
  before do
    start = Time.now - 60
    @eta = ProgressBar::ETA.new(start, 50, 100)
  end

  it 'should format properly' do
    @eta.to_s.must_equal "[ETA: 01:00]"
  end

  it 'should have the correct width' do
    @eta.width.must_equal 12
  end

  it 'should be 0 at the end' do
    eta = ProgressBar::ETA.new(Time.now - 5, 100, 100)
    eta.remaining.must_equal 0
  end

  it 'should not have an error at the start' do
    eta = ProgressBar::ETA.new(Time.now, 0, 100)
    eta.remaining.must_equal 0
    eta.to_s.must_equal "[ETA: 00:00]"
  end

  describe "long running tasks" do
    before do
      start = Time.now - 6*3600
      @eta = ProgressBar::ETA.new(start, 50, 100)
    end

    it 'should format properly' do
      @eta.to_s.must_equal "[ETA: 06:00:00]"
    end

    it 'should have the correct width' do
      @eta.width.must_equal 15
    end

  end

end
