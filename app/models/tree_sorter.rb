class TreeSorter
  def initialize(relations)
    @sorted = []
    @relations = relations
  end

  def sort_by_depth_first
    root = @relations
            .select{|relation| relation.values.first.empty?}
            .map{|relation| relation.keys.first}
    search(root)
    @sorted.flatten!
  end

  def search(target)
    target.each do |parent|
      next_target = @relations
                      .select{|relation| relation.values.first == parent}
                      .map{|v|v.keys.first}
      @sorted << next_target
      search(next_target)
    end
  end
end
