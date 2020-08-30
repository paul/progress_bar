# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ProgressBar print output" do
  let(:progress_bar) { ProgressBar.new(:counter) }

  before do
    allow(progress_bar).to receive(:terminal_width).and_return(10)
  end

  it "should replace the current bar with the text, and continue the bar on the next line" do
    expect {
      progress_bar.increment!
      progress_bar.puts("Hello, world!")
    }.to output("\r[  1/100]" \
                "\r#{' ' * 10}" \
                "\rHello, world!\n" \
                "\r[  1/100]").to_stderr
  end
end
