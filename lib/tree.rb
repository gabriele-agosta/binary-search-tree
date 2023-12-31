require_relative 'node'

class Tree

    def initialize(array=[])
        @array = clean_array(array)
        @root = build_tree(@array)
    end

    def build_tree(array=[], left_pointer=0, right_pointer=array.length)
        return nil if left_pointer > right_pointer
    
        mid = (left_pointer + right_pointer) / 2
        root = Node.new(array[mid])
        
        root.left = build_tree(array, left_pointer, mid - 1)
        root.right = build_tree(array, mid + 1, right_pointer)

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

    def find(value, node=@root)
        return node if node.data == value

        if node.data > value
            find(value, node.left)
        else
            find(value, node.right)
        end
    end

    def level_order()
        queue = Array.new 
        node = @root
        result = Array.new
        queue.append(node) if !node.nil?

        until queue.empty?
            result << node.data unless node.data.nil?
            queue << node.left unless node.left.nil?
            queue << node.right unless node.right.nil?
            queue.shift
            node = queue[0]
        end
        
        return result
    end

    def inorder(node=@root, result=[])
        return result if node.nil? 

        inorder(node.left, result)
        result << node.data unless node.data.nil?
        inorder(node.right, result)
    end

    def preorder(node=@root, result=[])
        return result if node.nil? 

        result << node.data unless node.data.nil?
        preorder(node.left, result)
        preorder(node.right, result)
    end

    def postorder(node=@root, result=[])
        return result if node.nil? 

        postorder(node.left, result)
        postorder(node.right, result)
        result << node.data unless node.data.nil?
    end

    def height(node=@root)
        if node.is_a? Integer
            node = find(node)
        end

        return -1 if node.nil?
        return 1 + [height(node.left) , height(node.right)].max
    end

    def depth(value=@root.data, node=@root)
        return -1 if node.nil? 

        return 0 if value == node.data 

        return 1 + [depth(value, node.left), depth(value, node.right)].max
    end

    def balanced?()
        left = @root.left
        right = @root.right

        return height(left) == height(right)
    end

    def rebalance()
        nodes = inorder()
        @root = build_tree(nodes)
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