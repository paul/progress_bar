require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

describe "Elapsed formatter" do
  before do
    start = Time.now - 60
    @elapsed = ProgressBar::Elapsed.new(start)
  end

  it 'should format properly' do
    @elapsed.to_s.must_equal "[01:00]"
  end

  it 'should have the correct width' do
    @elapsed.width.must_equal 7
  end

  describe "long running tasks" do
    before do
      start = Time.now - 6*3600
      @elapsed = ProgressBar::Elapsed.new(start)
    end

    it 'should format properly' do
      @elapsed.to_s.must_equal "[06:00:00]"
    end

    it 'should have the correct width' do
      @elapsed.width.must_equal 10
    end

  end

end
