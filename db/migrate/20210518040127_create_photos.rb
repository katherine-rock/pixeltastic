class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :title, null: false
      t.text :description
      t.integer :price, null: false
      t.string :category
      t.string :style

      t.timestamps
    end
  end
end
