class CreateBellaObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :bella_objects do |t|
      t.integer :conf_level

      t.timestamps
    end
  end
end
