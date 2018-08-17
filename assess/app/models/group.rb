# Created by: Pranay Methuku 7/22
#
# Model for groups
#

class Group < ApplicationRecord
  has_and_belongs_to_many :students
end
