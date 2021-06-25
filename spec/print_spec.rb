# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ProgressBar print output" do
  let(:io) { StringIO.new }
  let(:progress_bar) { ProgressBar.new(:counter, dest: io) }

  before do
    allow(progress_bar).to receive(:terminal_width).and_return(10)
  end

  it "should replace the current bar with the text, and continue the bar on the next line" do
    progress_bar.increment!
    progress_bar.puts("Hello, world!")
    io.rewind

    expect(io.read).to eq("\r[  1/100]" \
                          "\r#{' ' * 10}" \
                          "\rHello, world!\n" \
                          "\r[  1/100]")
  end
end
