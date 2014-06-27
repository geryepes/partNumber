class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :leter
      t.integer :nro
      t.string :title
      t.text :reference
      t.references :model, index: true

      t.timestamps
    end
  end
end
