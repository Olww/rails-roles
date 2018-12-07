class AddTextToBellaObjects < ActiveRecord::Migration
  def change
    add_column :bella_objects, :text, :text
  end
end
