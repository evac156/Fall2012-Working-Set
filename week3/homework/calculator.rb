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
        foundValue = false
        if ((p1.is_a? Numeric) && p2 && (p2.is_a? Numeric))
            outProd = p1 * p2
        elsif ((p1.is_a? Array) && !p2)
            p1.each do |p|
                if (p.is_a? Numeric)
                    if (!foundValue)
                        foundValue = true
                        outProd = p
                    else
                        outProd *= p
                    end
                end
            end
        end
        outProd
    end
end
