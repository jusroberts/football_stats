class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :url
      t.integer :range

      t.timestamps
    end
  end
end
