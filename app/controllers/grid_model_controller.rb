require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/traversal'
require 'rgl/dijkstra.rb'

class GridModelController < ApplicationController
  before_action :authenticate_user!
  before_action :generate_graph
  before_action :write_graph

  def index
  end

  def check
    respond_to do |format|
      if has_access?(params[:subject_level].to_i, params[:object_level].to_i)
        format.html { redirect_to grid_model_index_url, notice: 'The subject has access to the object.' }
      else
        format.html { redirect_to grid_model_index_url, alert: 'The subject has not access to the object.' }
      end
    end
  rescue RGL::NoVertexError => e
    redirect_to grid_model_index_url, alert: 'Wrong subject or object level!'
  end

  private
  def grid_model_params
    params.permit(:subject_level, :object_level)
  end

  def generate_graph
    @graph = RGL::DirectedAdjacencyGraph.new
    @graph.add_edge 1, 2
    @graph.add_edge 1, 3
    @graph.add_edge 1, 5
    @graph.add_edge 2, 6
    @graph.add_edge 2, 10
    @graph.add_edge 3, 6
    @graph.add_edge 3, 9
    @graph.add_edge 3, 15
    @graph.add_edge 5, 10
    @graph.add_edge 5, 15
    @graph.add_edge 6, 18
    @graph.add_edge 6, 30
    @graph.add_edge 9, 18
    @graph.add_edge 9, 45
    @graph.add_edge 10, 30
    @graph.add_edge 15, 45
    @graph.add_edge 15, 30
    @graph.add_edge 18, 90
    @graph.add_edge 45, 90
    @graph.add_edge 30, 90
  end

  def write_graph
    @graph.to_undirected.write_to_graphic_file('jpg', Rails.root.join("public", "/graph").to_s)
    # @graph.write_to_graphic_file('jpg')
  end

  def has_access?(subject_level, object_level)
    subject_level >= object_level && has_path?(object_level.to_i, subject_level.to_i)
  end

  def has_path?(from, to)
    t = @graph.bfs_search_tree_from(from)
    t.has_vertex?(to)
  end
end
