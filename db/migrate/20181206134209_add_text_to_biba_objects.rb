class AddTextToBibaObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :biba_objects, :text, :text
  end
end
