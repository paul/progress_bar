
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib/progress_bar'))

require 'rspec'
require 'timecop'

RSpec.configure do |cfg|
  cfg.after do
    Timecop.return
  end
end

