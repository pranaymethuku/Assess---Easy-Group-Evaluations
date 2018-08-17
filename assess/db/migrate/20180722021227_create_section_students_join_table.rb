class CreateSectionStudentsJoinTable < ActiveRecord::Migration[5.1]
  def change
    # If you want to add an index for faster querying through this join:
    create_join_table :sections, :students do |t|
      t.index :section_id
      t.index :student_id
    end
  end
end
