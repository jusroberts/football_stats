class AddFieldsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :name, :string
    add_column :stats, :value, :string
  end
end
