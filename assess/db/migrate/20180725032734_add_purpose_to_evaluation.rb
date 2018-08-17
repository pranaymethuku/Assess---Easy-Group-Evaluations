class AddPurposeToEvaluation < ActiveRecord::Migration[5.1]
  def change
    add_column :evaluations, :purpose, :string
  end
end
