class AddTextToBibaObjects < ActiveRecord::Migration
  def change
    add_column :biba_objects, :text, :text
  end
end
