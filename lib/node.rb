class Node

    include Comparable 
    attr_accessor :left, :right, :data

    def initialize(data)
        @left = nil
        @right = nil
        @data = data
    end

    def <=>(other_node) 
        @data <=> other_node.data
    end

    def to_s
        return @data
    end
end

