class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id, :null => false
      t.string :position, :null => false, :limit => 255

      t.timestamps
    end
  end
end
