class CreateTripnotes < ActiveRecord::Migration[5.2]
  def change
    create_table :tripnotes do |t|
      t.text :detail
      t.belongs_to :memory, foreign_key: true

      t.timestamps
    end
  end
end
