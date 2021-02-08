class Tree

    require_relative 'node'

    def initialize(array)
        @root = build_tree(array)
    end

    def build_tree(array)
        array = check_for_duplicates(array.sort)
        #puts array.to_s
        array.map! {|element| element = Node.new(element)}
        @root = array[array.length/2]
        mid_point = array[array.length/2]
        mid_point_index = array.index(mid_point)

        if(array.length > 1)

            @root.left = build_branches(array[0..(mid_point_index-1)])
            @root.right = build_branches(array[(mid_point_index+1)..(array.length-1)])
        end
        return @root
    end

    def build_branches(array)

        mid_point = array[array.length/2]
        mid_point_index = array.index(mid_point)

        case(array.length)
        when 0..1
            mid_point = array[0]
        when 2
            mid_point.left = build_branches([array[0]])
        when 3
            mid_point.right = build_branches([array[2]])
            mid_point.left = build_branches([array[0]])
        else
            mid_point.left = build_branches(array[0..(mid_point_index-1)])
            mid_point.right = build_branches(array[(mid_point_index+1)..((array.length)-1)])
        end          
        return mid_point
    end

    def insert(value)
        value = Node.new(value)
        if check_in_tree(value,@root)
            puts "Element is already in the Tree, duplicates are not allowed!"
        else
            insert_element(@root,value)
        end     
    end

    def insert_element(root,value)
        if(value < root)
            if(defined?(root.left.data))
                insert_element(root.left,value)     
            else
                root.left = value
            end
        else
            if(defined?(root.right.data))
                insert_element(root.right,value)          
            else
                root.right = value
            end    
        end
        rebalance()
    end

    def delete_element(root,oldroot, value)
        if ((value < root) && (defined?(root.left.data)))
            delete_element(root.left,root,value)
        elsif ((value > root)  && (defined?(root.right.data)))
            delete_element(root.right,root,value)
        
        elsif(value == root)
           
            next_elm = find_next_lowest(root.right)
            parent =  find_parent(@root,root)

            #node with one or zero children
            if next_elm.is_a?(NilClass)

                if(defined?(root.left.data))
                    parent.right = root.left
                
                else
                    (parent.left == value) ?   parent.left = nil : parent.right = nil

                end
            #node with 2 children
            else
                puts next_elm.to_s
                next_elm_parent = find_parent(@root,next_elm)

                if(next_elm_parent == root)
                    next_elm.left = root.left
                    (parent.left == value) ?   parent.left = next_elm : parent.right = next_elm
                else
                    next_elm_parent.left = nil
                    next_elm.left = root.left
                    next_elm.right = root.right

                    (parent.left == value) ?   parent.left = next_elm : parent.right = next_elm
                end
            end
            rebalance()
        else
            puts "value not in the tree"
        end
    end

    def check_in_tree(element,root)
        if root == element
            return true
        else

            if((defined?(root.left.data))) || ((defined?(root.right.data)))
                if(element < root)
                    check_in_tree(element,root.left)
                else
                    check_in_tree(element,root.right)
                end
            else
                return false
            end
        end
    end
    

    def find(element,root)
        if root.data == element
            return root
        else
            if((defined?(root.left.data))) || ((defined?(root.right.data)))
                if(element < root.data)
                    find(element,root.left)
                else
                    find(element,root.right)
                end
            else
                return "The value #{element} is not in a node in the tree"
            end
        end
    end

    #finds the parent for any node
    def find_parent(root, parent_to_find)

        if((defined?(root.left.data))) || ((defined?(root.right.data)))
            if(root.right == parent_to_find) || (root.left == parent_to_find) 
                return  root
            else
                if(parent_to_find < root)
                    find_parent(root.left, parent_to_find)
                else
                    find_parent(root.right,parent_to_find)
                end     
            end
        end   
    end


    def delete(value)
        value = Node.new(value)
        if (value == @root)
            new_root = find_next_lowest(@root.right)
            find_next_lowest_parent(@root.right).left = nil
            new_root.left = @root.left  
            new_root.right = @root.right
            @root = new_root
            rebalance      
        else
            delete_element(@root,@root,value)
        end   
    end

    def find_next_lowest(node)
        if(defined?(node.left.data))
            find_next_lowest(node.left)
        else
            return node
        end
    end

    def find_next_lowest_parent(node)
        if(defined?(node.left.left.data))
            find_next_lowest_parent(node.left)
        else
            return node
        end
    end

    def rebalance()
        element_list = []
        get_elements_into_array(@root,array = []).each{|el| element_list.push(el.data)}
        element_list =  element_list.sort
        build_tree(element_list)
    end

    def get_elements_into_array(node,array = [])
        
        array.push(node)
        if(defined?(node.left.data))
            get_elements_into_array(node.left,array)
        end
        if(defined?(node.right.data))     
            get_elements_into_array(node.right,array)
        end
        return array     
    end

    def check_for_duplicates(array)
        delete_list = []
        array.each_with_index do |element, index|
            if(array[index+1] == element)
                delete_list.push(index)
            end
        end
        delete_list.reverse.each {|element| array.delete_at(element)}
        return array
    end

    def level_order_traversal()
        queue = []
        level_order = []
        queue.unshift @root

        while(queue != [])
            next_item = queue.pop
            level_order.push(next_item.data)
            if(defined?(next_item.left.data))
                queue.unshift(next_item.left)

            end
            if(defined?(next_item.right.data))
                queue.unshift(next_item.right)
            end
        end

        return level_order.to_s
    end

    def inorder(root,return_array = [])

        if(!defined?(root.data))
            return
        end
        if(defined?(root.left))
            inorder(root.left,return_array)
        end

        return_array.push(root.data)
        if(defined?(root.right))
            inorder(root.right,return_array)
        end

        return return_array.to_s

    end
    def preorder(root,return_array = [])
        return_array.push(root.data)
        if(defined?(root.left.data))
            preorder(root.left,return_array)
        end
        if(defined?(root.right.data))
            preorder(root.right,return_array)
        end

        return return_array.to_s
    end

    def postorder(root,return_array = [])
        if(!defined?(root.data))
            return
        end
        if(defined?(root.left))
            postorder(root.left,return_array)
        end
        if(defined?(root.right))
            postorder(root.right,return_array)
        end
        return_array.push(root.data)
        return return_array.to_s
    end

    def root
        return @root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

a = Tree.new([100,1,0,0,0,1,1,3,4,5,6,2,3,4,5,34,23,656,34,23,1,3,65,456,354,24,234,63,13,43,65,7,8,9])


b = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14])



#a.delete(493090)
b.pretty_print
#a.get_elements_into_array(32)
puts b.level_order_traversal
puts b.find(11,b.root)

puts b.preorder(b.root)
puts b.inorder(b.root)
puts b.postorder(b.root)

c = Tree.new([1,2,3,4,5,6])
c.pretty_print
puts "preorder"
puts c.preorder(c.root)
puts "inorder"
puts c.inorder(c.root)
puts "postorder"
puts c.postorder(c.root)




