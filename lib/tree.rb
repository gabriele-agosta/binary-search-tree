require_relative 'node'

class Tree

    def initialize(array=[])
        @array = clean_array(array)
        @root = build_root(@array)
    end

    def build_root(array=[], left_pointer=0, right_pointer=array.length)
        return nil if left_pointer > right_pointer
        
        # require 'pry-byebug'; binding.pry
        mid = (left_pointer + right_pointer) / 2
        root = Node.new(array[mid])
        
        root.left = build_root(array, left_pointer, mid - 1)
        root.right = build_root(array, mid + 1, right_pointer)

        return root
    end

    def root()
        return @root.data
    end

    def insert(root=@root, value)
        return nil if root.nil?

        if value < root.data
            root.left.nil? ? root.left = Node.new(value) : insert(root.left, value)
        else
            root.right.nil? ? root.right = Node.new(value) : insert(root.right, value)
        end
    end

    def delete(value)
        father = @root
        son = nil

        until father.nil? && father.data == value
            # Mi serve mantenere padre e figlio per evitare di scorrere due volte quando devo cancellare
            # Quando uno dei due figli del padre ha il valore, allora esco dal ciclo e chiamo la funzione

            if father.data > value
                son = father.left if father.left.data == value
            elsif father.data < value
                son = father.right if father.right.data == value
            else
                son = father
            end
            
            if !son.nil?
                rebalance_tree(father, son)
                return
            end
            value > father.data ? father = father.right : father = father.left 
        end
        return "The value isn't in the tree"
    end

    private
    def clean_array(array)
        return array.uniq.sort
    end

    private
    def rebalance_tree(father, son)
        if father.data > son.data 
            father.left = find_new_son(son)
        else
            father.right = find_new_son(son)
        end
        require 'pry-byebug'; binding.pry
    end

    private
    def find_new_son(node)
        sons = count_sons(node)

        if sons == 0
            return nil
        elsif sons == 1
            if node.left.nil? 
                return node.right
            else
                return node.left
            end
        else
            node = node.right
            until node.left.nil?
                node = node.left
            end
            return node
        end
    end

    private
    def count_sons(node)
        count = 0
        count += 1 if !node.left.nil?
        count += 1 if !node.right.nil?
        return count
    end
end