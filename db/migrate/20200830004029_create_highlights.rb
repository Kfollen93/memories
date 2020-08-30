class CreateHighlights < ActiveRecord::Migration[5.2]
  def change
    create_table :highlights do |t|
      t.string :bullet
      t.belongs_to :memory, foreign_key: true

      t.timestamps
    end
  end
end
