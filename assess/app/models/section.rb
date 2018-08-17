# Created by: Pranay Methuku 7/22
#
# Model for sections
#

class Section < ApplicationRecord
  has_and_belongs_to_many :students  
end
