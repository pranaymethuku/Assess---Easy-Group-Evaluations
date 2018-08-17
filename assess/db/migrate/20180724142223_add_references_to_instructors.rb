class AddReferencesToInstructors < ActiveRecord::Migration[5.1]
  def change
    add_reference :instructors, :comment, foreign_key: true
  end
end
