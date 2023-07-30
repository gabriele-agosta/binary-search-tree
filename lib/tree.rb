require_relative 'node'

class Tree


    def initialize(array=[])
        @array = clean_array(array)
        @root = build_root(@array)
    end

    def build_root(array=[], root=nil)
        return root if array.empty?
        
        # require 'pry-byebug'; binding.pry
        first = 0
        last = array.size - 1
        mid = (first + last) / 2

        root = Node.new(array[mid])
        
        build_root(array[first, mid], root.left)
        build_root(array[mid + 1, last], root.right)
    end

    def root()
        return @root.data
    end

    private
    def clean_array(array)
        return array.uniq.sort
        
    end
end