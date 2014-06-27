class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :autor
      t.integer :nro
      t.date :fecha
      t.references :state, index: true
      t.references :part, index: true

      t.timestamps
    end
  end
end
