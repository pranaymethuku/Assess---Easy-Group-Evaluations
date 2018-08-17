# Created by: Pranay Methuku 7/24
#
# Helper for group paths
#
# Functions: 
#   new_class_group_path - gets path for getting new class group
#   create_class_group_path - gets path for creating class group
#   class_groups_path - gets path for getting all class groups
#   class_group_path - gets path for getting one class group
#   add_group_student_path - gets path for adding new group student
#   link_group_student_path - gets path for linking group student
#   group_students_path - gets path for getting all group students
#   remove_group_student_path - gets path for removing one group student
#
module GroupsHelper

  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting new class group
  #   
  # Args:
  #   section (Section) - ApplicationRecord for Section
  #
  def new_class_group_path(section)
    "/instructors/class/" + section.id.to_s + "/group/new"
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for creating class group
  #   
  # Args:
  #   section (Section) - ApplicationRecord for Section
  #
  def create_class_group_path(section)
    "/instructors/class/" + section.id.to_s + "/group/create"
  end
  
  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting all class groups
  #   
  # Args:
  #   section (Section) - ApplicationRecord for Section
  #
  def class_groups_path(section)
    "/instructors/class/" + section.id.to_s + "/groups"
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting one class group
  #   
  # Args:
  #   group (Group) - ApplicationRecord for Group
  #
  def class_group_path(group)
    "/instructors/class/" + group.section_id.to_s + "/group/" + group.id.to_s
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for adding new group student
  #   
  # Args:
  #   group (Group) - ApplicationRecord for Group
  #
  def add_group_students_path(group)
    "/instructors/group/" + group.id.to_s + "/student/add"
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for linking group student
  #   
  # Args:
  #   group (Group) - ApplicationRecord for Group
  #
  def link_group_students_path(group)
    "/instructors/group/" + group.id.to_s + "/students/link"
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting all group students
  #   
  # Args:
  #   group (Group) - ApplicationRecord for Group
  #
  def group_students_path(group)
    if current_instructor
      "/instructors/group/" + group.id.to_s + "/students"
    elsif current_student
      "/students/group/" + group.id.to_s + "/students"
    end
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for removing one group student
  #   
  # Args:
  #   group (Group) - ApplicationRecord for Group
  #   section (Section) - ApplicationRecord for Section
  #
  def remove_group_student_path(group, student)
    "/instructors/group/" + group.id.to_s + "/student/" + student.id.to_s + "/remove"
  end
end
