class AddUserRefToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_reference :photos, :user, null: false, foreign_key: true
  end
end
