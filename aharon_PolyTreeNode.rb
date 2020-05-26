class PolyTreeNode
    attr_reader :parent, :children, :value
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(value)
        @parent.children.delete(self) unless @parent == nil
        @parent = value
        @parent.children << self unless value == nil
    end

    def add_child(child_node)
        child_node.parent=(self)
    end

    def remove_child(child_node)
        raise "not a child" unless @children.include?(child_node)
        child_node.parent=(nil)
        @children.delete(child_node)
    end

    def dfs(target_value)
        return self if self.value == target_value
        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]

        until queue.empty?
            first_node = queue.shift
            return first_node if first_node.value == target_value
            first_node.children.each { |child| queue << child }
        end
        nil
    end
end