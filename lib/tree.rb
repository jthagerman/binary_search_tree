class Tree

    require_relative 'node'

    def initialize(array)
        @root = build_tree(array)

    end

    def build_tree(array)
        array = check_for_duplicates(array.sort)
        puts array.to_s

        root = array[array.length/2]
        puts root

    #    1) Get the Middle of the array and make it root.
#2) Recursively do same for left half and right half.
 #     a) Get the middle of left half and make it left child of the root
  #        created in step 1.
   #   b) Get the middle of right half and make it right child of the
    #      root created in step 1.



        #turn into node objects

        #return the root level node

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
        return array.to_s
    end


end
a = Tree.new([100,1,0,0,0,1,1,3,4,5,6,2,3,4,5])
