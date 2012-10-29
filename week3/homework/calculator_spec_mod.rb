require "#{File.dirname(__FILE__)}/calculator"

describe Calculator do
  
  before do
    @calculator = Calculator.new
  end

  describe "#sum" do
    it "computes the sum of an empty array" do
      @calculator.sum([]).should == 0
    end
    
    it "computes the sum of an array of one number" do
      @calculator.sum([7]).should == 7
    end
    
    it "computes the sum of an array of two numbers" do
      @calculator.sum([7,11]).should == 18
    end
    
    it "computes the sum of an array of many numbers" do
      @calculator.sum([1,3,5,7,9]).should == 25
    end

    it "skips over non-numerics in an array" do
      @calculator.sum([1,3,"pancake",7,"cornflake",11]).should == 22
    end

    it "skips everything when none of them are numeric" do
      @calculator.sum(["one", "two", "three", "four"]).should == 0
    end

    it "does nothing if it's passed a nil" do
      @calculator.sum(nil).should == 0
    end
  end
  
  # Once the above tests pass, 
  # write tests and code for the following:
  
  describe "#product" do
    it "multiplies two numbers" do
      @calculator.product(6, 7).should == 42
      @calculator.product(-11, 13).should == (-143)
      @calculator.product(9.3, 7.22).should == 67.146
    end

    it "returns 0 when its argument is nil" do
      @calculator.product(nil).should == 0
    end

    it "returns 0 when the array of numbers is empty" do
      @calculator.product([]).should == 0
    end

    it "returns the single value when the array contains only one number" do
      @calculator.product([3]).should == 3
      @calculator.product([2001]).should == 2001
      @calculator.product([-333]).should == (-333)
      @calculator.product([13.13]).should == 13.13
    end

    it "multiplies an array of numbers" do
      @calculator.product([2, 5]).should == 10
      @calculator.product([15, -13, 2]).should == (-390)
      @calculator.product([6, 2.5, -3, 6.1]).should == (-274.5)
      @calculator.product([-11, 16, -0.25, 3, 1.5]).should == 198
    end
  end
  
  it "raises one number to the power of another number"
  
  # http://en.wikipedia.org/wiki/Factorial
  describe "#factorial" do
    it "computes the factorial of 0"
    it "computes the factorial of 1"
    it "computes the factorial of 2"
    it "computes the factorial of 5"
    it "computes the factorial of 10"
  end

end
