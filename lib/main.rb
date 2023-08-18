require_relative 'tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)

tree.build_root(array)
tree.insert(25)
tree.delete(23)
tree.find(67)
p "Level order #{tree.level_order()}"
p "Inorder #{tree.inorder()}"
p "Preorder #{tree.preorder()}"
p "Postorder #{tree.postorder()}"