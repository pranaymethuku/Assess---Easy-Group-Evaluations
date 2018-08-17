class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :student, foreign_key: true
      t.references :group, foreign_key: true
      t.references :section, foreign_key: true
      t.date :date_completed
      t.text :contribution
      t.text :team_contribution
      t.text :managers
      t.text :manager_performance
      t.text :outstanding_participation
      t.text :poor_participation
      t.text :other

      t.timestamps
    end
  end
end
