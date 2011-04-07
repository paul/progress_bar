
%w[
  counter
  bar
  percentage
  elapsed
  eta
].each do |meter|
  require File.join(File.dirname(__FILE__), 'meters', meter)
end
