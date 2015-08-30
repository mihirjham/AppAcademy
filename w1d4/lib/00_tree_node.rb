class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    parent.children.delete(self) if !parent.nil?

    @parent = node
    if(node.nil?)
      return
    end

    if(!node.children.include?(self))
      node.children.push(self)
    end
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    if(!node.parent.children.include?(node))
      return nil
    end
    node.parent = nil
  end

  def dfs(target_value)
    if self.value == target_value
      return self
    else
      value = nil
      children.each do |child|
        value = child.dfs(target_value)
        if(!value.nil?)
          break
        else
        end
      end
    end
    value
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each do |child|
        queue << child
      end
    end

    nil
  end

  def trace_path_back
    path = []
    current_node = self

    while(!current_node.nil?)
      path << current_node.value
      current_node = current_node.parent
    end

    path.reverse
  end
end
