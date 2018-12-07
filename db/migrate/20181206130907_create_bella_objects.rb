class CreateBellaObjects < ActiveRecord::Migration
  def change
    create_table :bella_objects do |t|
      t.integer :conf_level

      t.timestamps
    end
  end
end
