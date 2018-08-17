# Created by: Pranay Methuku 7/22
#
# Model for students
#

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable, :timeoutable

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :sections  

  validates :first_name, :last_name, presence: true
end
