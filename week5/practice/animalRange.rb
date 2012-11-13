class Animal

# Usage example:
# load animalRange.rb
#
# r1 = Animal.new("ant")
# r2 = Animal.new("egret")
#
# r1.succ
# r1.prev
# r2.prev
# r2.succ
# r1.succ.succ.prev
#
# myRange = (r1..r2)
#
# myRange.each do |x|
#   puts "#{x.index}: #{x.name}"
# end

@@A_NAME = "ant"
@@B_NAME = "bear"
@@C_NAME = "cougar"
@@D_NAME = "deer"
@@E_NAME = "egret"

@@NAMES = [@@A_NAME, @@B_NAME, @@C_NAME, @@D_NAME, @@E_NAME]

attr_reader :name, :index

@@ANIMALS = nil

def initialize(inName)
    puts ("@@NAMES = #{@@NAMES.inspect}, @@NAMES.object_id = #{@@NAMES.object_id}")
    @index = @@NAMES.find_index(inName)
    if (@index)
        puts("The @index of #{inName} is #{@index}")
    else
        puts("#{inName} has no @index")
    end
    if (@@ANIMALS)
        puts("@@ANIMALS is defined, with object_id = #{@@ANIMALS.object_id}.")
    else
        puts("@@ANIMALS is not defined.")
    end
    if (@index)
        @name = @@NAMES[index]
    else
        @name = nil
    end
    @index.freeze
    @name.freeze
end

@@ANIMALS = { @@A_NAME => Animal.new(@@A_NAME),
            @@B_NAME => Animal.new(@@B_NAME),
            @@C_NAME => Animal.new(@@C_NAME),
            @@D_NAME => Animal.new(@@D_NAME),
            @@E_NAME => Animal.new(@@E_NAME)
          }

def succ
    ret = nil
    if (@index && (@index < @@NAMES.length))
        ret = @@ANIMALS[@@NAMES[@index+1]]
    end
    ret
end

def prev
    ret = nil
    if (@index && (@index > 0))
        ret = @@ANIMALS[@@NAMES[@index-1]]
    end
    ret
end

def <=>(otherAnimal)
    @index <=> otherAnimal.index
end

def to_s
    @name
end

def showNames
    puts ("@@NAMES = #{@@NAMES.inspect}, @@NAMES.object_id = #{@@NAMES.object_id}")
end

end
