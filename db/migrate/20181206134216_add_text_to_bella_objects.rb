class AddTextToBellaObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :bella_objects, :text, :text
  end
end
