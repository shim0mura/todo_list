class ChangeTaskEstimateFromIntToVarchar < ActiveRecord::Migration
  def change
    change_column :tasks, :estimate, :string, :limit => 11
  end
end
