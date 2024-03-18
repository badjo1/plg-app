class CreateWalls < ActiveRecord::Migration[7.1]
  def change
    create_table :walls do |t|
      t.string :title

      t.timestamps
    end
  end
end
