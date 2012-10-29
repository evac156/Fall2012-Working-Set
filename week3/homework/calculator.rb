class Calculator

    # Add an array of numbers, returning the sum. Empty arrays and nil return
    # zero, and non-numeric values are skipped (should probably throw Exception)
    def sum(inArr)
        outSum = 0
        if (inArr)
            inArr.each do |p|
                if (p.is_a? Numeric)
                    outSum += p
                end
            end
        end
        outSum
    end

    # Multiply either two numbers, or an array of numbers. Since Ruby doesn't
    # allow multiple signatures for the same method name, need to handle the
    # two cases via optional parameters and type checking. (There must be a way
    # to enforce parameter types, but we haven't seen it yet.) Special cases:
    # nil or an empty array returns zero; an array of one element returns that
    # element (zero might be better). Any non-numeric values are skipped.
    def product(p1, p2 = nil)
        outProd = 0
        haveNumbers = false
        # If we have two parameters, both numeric
        if ((p1.is_a? Numeric) && p2 && (p2.is_a? Numeric))
            outProd = p1 * p2
        # If we have one parameter which is an array
        elsif ((p1.is_a? Array) && !p2)
            p1.each do |p|
                # Only care about numeric values
                if (p.is_a? Numeric)
                    # First number found becomes the product value so far
                    if (!haveNumbers)
                        haveNumbers = true
                        outProd = p
                    # All subsequent numbers multiply the existing product
                    else
                        outProd *= p
                    end
                end
            end
        end
        outProd
    end

    # Raise a number to an integer power. We don't mess around with non-integral
    # powers. And we certainly don't try to do anything with non-numerics.
    def exp(base, exp)
        product = nil
        negativePower = false
        counter = 0
        if (base && exp && (base.is_a? Numeric) && (exp.is_a? Integer))
            negativePower = (exp < 0)
            counter = exp.abs
            product = 1
            counter.times do
              product *= base
            end
            if (negativePower)
              product = 1.0 / product
            end
        end
        product
    end
end
