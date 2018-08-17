# Created by: Michael Lynch 7/24
# Edited by: Sayeef Moyen 7/25 - added validations
#   
# Model for evaluations
#

class Evaluation < ApplicationRecord
    validates :purpose, :contribution, :team_contribution, :managers, :manager_performance, \
     :outstanding_participation, :poor_participation, presence: true
end
