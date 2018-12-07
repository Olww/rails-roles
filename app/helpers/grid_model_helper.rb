module GridModelHelper
  def has_path?(from, to)
    t = @graph.bfs_search_tree_from(from)
    puts t.has_vertex?(to)
  end

  def has_access?(subject_level, object_level)
    subject_level >= object_level && has_path?(object_level, subject_level) ? "Yea! U got it!" : "Not today :("
  end

end
