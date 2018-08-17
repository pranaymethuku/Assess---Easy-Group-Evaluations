# Created by: Pranay Methuku 7/22
#
# Model for instructors
#

class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
	       :validatable, :confirmable, :lockable, :timeoutable

  has_many :sections

  validates_associated :sections
  end
