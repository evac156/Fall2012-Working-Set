require './symMod1.rb'
require './symMod2.rb'

class PracClass
	include SymMod1
    include SymMod2

    def show1
        v = getHash1
        puts v.inspect
        puts ":shared_symbol.object_id #{:shared_symbol.object_id}"
        puts ":unique1.object_id #{:unique1.object_id}"
    end

    def show2
        v = getHash2
        puts v.inspect
        puts ":shared_symbol.object_id #{:shared_symbol.object_id}"
        puts ":unique2.object_id #{:unique2.object_id}"
    end

    def showBoth
        v1 = getHash1
        v2 = getHash2
        v3 = Hash.new
        v1.each { |k, v| v3[k] = v }
        v2.each { |k, v| v3[k] = v }
        puts "v1 = #{v1.inspect}"
        puts "v2 = #{v2.inspect}"
        puts "v3 = #{v3.inspect}"
        puts ":shared_symbol.object_id #{:shared_symbol.object_id}"
        puts ":unique1.object_id #{:unique1.object_id}"
        puts ":unique2.object_id #{:unique2.object_id}"
    end
end
