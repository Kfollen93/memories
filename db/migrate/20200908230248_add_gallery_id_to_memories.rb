class AddGalleryIdToMemories < ActiveRecord::Migration[5.2]
  def change
    add_reference :memories, :gallery, foreign_key: true
  end
end
