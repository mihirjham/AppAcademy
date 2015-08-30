require './00_tree_node'
class KnightPathFinder
  attr_reader :start_pos, :root

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end

  def self.valid_moves(pos)
    offsets = [
      [-2, 1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1]
    ]

    offsets.map! do |offset|
      [pos[0] + offset[0], pos[1] + offset[1]]
    end

    offsets.select do |valid_pos|
      (valid_pos[0] >= 0 && valid_pos[0] <= 7) && (valid_pos[1] >= 0 && valid_pos[1] <= 7)
    end
  end

  def new_move_positions(pos)
    array = KnightPathFinder::valid_moves(pos) - @visited_positions
    @visited_positions += array
    array
  end

 def build_move_tree
   @root = PolyTreeNode.new(@start_pos)
   queue = [@root]

   until queue.empty?
     current_pos = queue.shift
     valid_pos = new_move_positions(current_pos.value)
     valid_pos.each do |move|
       move_node = PolyTreeNode.new(move)
       current_pos.add_child(move_node)
       queue << move_node
     end
   end
 end

 def find_path(end_pos)
   node = @root.bfs(end_pos)
   return node.trace_path_back
 end

end
