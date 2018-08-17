class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.integer :number
      t.string :name
      t.string :dept
      t.references :instructor, foreign_key: true

      t.timestamps
    end
  end
end
