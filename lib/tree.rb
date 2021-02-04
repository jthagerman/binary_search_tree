class Tree

    require_relative 'node'

    def initialize(array)

        @root = build_tree(array)

    end

    def build_tree(array)
        array = check_for_duplicates(array.sort)
        puts array.to_s
        array.map! {|element| element = Node.new(element)}

        @root = array[array.length/2]

        mid_point = array[array.length/2]
        mid_point_index = array.index(mid_point)

        @root.left = build_branches(array[0..(mid_point_index-1)])
        @root.right = build_branches(array[(mid_point_index+1)..(array.length-1)])

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
    end

    def delete(value)
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

    def root
        return @root.data
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end


end
a = Tree.new([100,1,0,0,0,1,1,3,4,5,6,2,3,4,5,34,23,656,34,23,1,3,65,456,354,24,234,63,13,43,65,7,8,9])
a.pretty_print

b = Tree.new([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
b.pretty_print



