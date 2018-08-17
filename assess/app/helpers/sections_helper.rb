# Created by: Pranay Methuku 7/24
#
# Helper for section path
#
# Functions: 
#   instructor_class_path - gets path for getting one instructor class
#
module SectionsHelper
  def instructor_class_path(section)
    "/instructors/class/" + section.id.to_s
  end
end
