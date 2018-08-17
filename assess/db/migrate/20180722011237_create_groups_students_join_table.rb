class CreateGroupsStudentsJoinTable < ActiveRecord::Migration[5.1]
  def change  
    # If you want to add an index for faster querying through this join:
    create_join_table :groups, :students do |t|
      t.index :group_id
      t.index :student_id
    end
  end
end
