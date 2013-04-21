class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :null => false, :limit => 30
      t.text :detail
      t.integer :estimate, :limit => 2
      t.datetime :limit
      t.integer :group_id
      t.boolean :finished, :default => false
      t.boolean :current, :default => false

      t.timestamps
    end
  end
end
