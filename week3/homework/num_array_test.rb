require "#{File.dirname(__FILE__)}/calculator"

# This is actually testing a private method; I made it public temporarily to
# test it.

describe Calculator do
  before do
    @calculator = Calculator.new
  end

  it "should return true on these" do
    Calculator.is_numeric_array?([]).should be_true # An array, all of whose elements are numeric
    Calculator.is_numeric_array?([1]).should be_true
    Calculator.is_numeric_array?([1, 3, 9.99]).should be_true
    Calculator.is_numeric_array?([-17, 9.99, 4.324e11, -7.7e-4]).should be_true
  end

  it "should return false on these" do
    Calculator.is_numeric_array?(nil).should be_false
    Calculator.is_numeric_array?(1).should be_false
    Calculator.is_numeric_array?("x").should be_false
    Calculator.is_numeric_array?(:fish).should be_false
    Calculator.is_numeric_array?([2, 4, 6, "eight", 10]).should be_false
    Calculator.is_numeric_array?([1, 3, 9.99, :fish]).should be_false
  end

end
