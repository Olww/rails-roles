class CreateBibaObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :biba_objects do |t|
      t.integer :conf_level

      t.timestamps
    end
  end
end
