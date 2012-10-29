# A method that takes an implicit block and converts it to a Proc
def create_block_object(&in_block)
    in_block
end

# Create a Proc object for doubling any incoming object
doubler = create_block_object { |p| puts "#{p}*2 = #{p*2}" }

# Find out about the created doubler Proc object
puts "Object doubler is of class #{doubler.class}"
puts "doubler.inspect returns #{doubler.inspect}"

# Try out the doubler Proc.
doubler.call 10
doubler.call "fish"
doubler.call ["zz", "yy", "xx"]
doubler.call [:a, :b]

# Not everything can be doubled.
begin
    puts "Trying to double the doubler"
    doubler.call doubler
    puts "Worked? Not likely!"
rescue Exception
    puts "That didn't work. Moving on..."
end

# Try explicitly creating a lambda Proc
threeParm = lambda {|p1,p2,p3| puts "lambda Proc received parms #{p1}, #{p2}, #{p3}"}

# Find out about the created threeParm Proc object
puts "Object threeParm is of class #{threeParm.class}"
puts "threeParm.inspect returns #{threeParm.inspect}"

# Try out the threeParm Proc. Should be able to pass it anything.
threeParm.call(2, 4, 6)
threeParm.call "99", "100", "101"
threeParm.call 3.14159, "zed", :random_symbol
threeParm.call [11, 12, 13], { "fish" => "tuna", "piano" => "tuner"}, threeParm

# Try creating a Proc with Proc.new instead of lambda
swapper = Proc.new do |p1, p2|
    puts "Original: #{p1}, #{p2}"
    puts "Reversed: #{p2}, #{p1}"
end

# Find out about the created swapper Proc object
puts "Object swapper is of class #{swapper.class}"
puts "swapper.inspect returns #{swapper.inspect}"

# Try out the swapper Proc. Should be able to pass it anything.
swapper.call "pdq", "xyz"
swapper.call "flavors", 31
swapper.call [:natty, :narwhal], { "intrepid" => "ibex", "hardy" => "heron" }

# Try creating a method that takes an incoming Proc and makes it a lambda
def cbo2 (&inBlock)
    returnLambda = nil
    begin
        puts "Received inBlock of class #{inBlock.class}"
        puts "Inspecting inBlock: #{inBlock.inspect}"
        puts "Converting inBlock to lambda"
        returnLambda = lambda inBlock
    rescue Exception
        puts "Got an Exception. Guess you can't do that. Returning nil."
    end
    returnLambda
end

# Create the Proc from another simple block
threepeater = cbo2 { |q| puts "#{q} #{q.upcase} #{q}" }

# But that one might not have worked
if (threepeater)
    threepeater.call "zoom"
else
    puts "Our object is nil. Doing nothing (except print this)"
end

# Make the same object in the more typical way
threepeater2 = lambda { |q| puts "#{q} #{q.upcase} #{q}" }

# This one works
threepeater2.call "pow"

# Try a lambda call with a do-end instead of brackets
strReverse = lambda do |inVal|
    puts inVal.to_s
    puts inVal.to_s.reverse
end

# Find out about the created strReverse Proc object
puts "Object strReverse is of class #{strReverse.class}"
puts "strReverse.inspect returns #{strReverse.inspect}"

# Invoke the string reverser. Works on anything because it uses .to_str
strReverse.call "abcde"
strReverse.call 12.34567890
strReverse.call ({ "New York" => "Yankees", "Oakland" => "Athletics", "Seattle" => "Mariners" })
strReverse.call strReverse

# Pass a do-end block to our original Proc creator
palindromer = create_block_object do |p1|
    t1 = p1.to_s
    t2 = t1.reverse
    t3 = t1 + t2
    puts t3
end

# Find out about the created palindromer Proc object
puts "Object palindromer is of class #{palindromer.class}"
puts "palindromer.inspect returns #{palindromer.inspect}"

# Make some palindromes (yes, problems with doubled middle character)
palindromer.call "amanaplanac"
palindromer.call "sitonapota"
palindromer.call "able was I er"

# Make an invoker method that takes a Proc and calls it on a parameter
def invoker(procObj, param1)
    puts "Invoking #{procObj} on #{param1.to_s}"
    procObj.call param1
end

# Try it out
invoker palindromer, "BigFish"
invoker strReverse, { :s1 => "sym1", :s2 => "sym2", :sbol => "symbol" }
invoker threepeater2, "ruby"

# Try defining the invoker differently
# It's tricky using multiple parameters including a block object. See p.333
# for an example.
def inv2(k, &blockObj)
    blockObj.call k
end

inv2(3) { |p1| puts "strlen(#{p1}) = #{p1.to_s.length}" }
inv2(99) { |p1| puts "strlen(#{p1}) = #{p1.to_s.length}" }
inv2("How long is this string?") { |p1| puts "strlen(#{p1}) = #{p1.to_s.length}" }
inv2("BigFish") { |p1| palindromer.call p1 }
