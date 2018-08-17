# Created by: Pranay Methuku 7/24
#
# Helper for evaluation paths
#
# Functions: 
#   fill_student_evaluation_path - gets path for filling student evaluation
#   create_student_evaluation_path - gets path for creating student evaluation
#   class_groups_path - gets path for getting all class groups
#   student_evaluation_path - gets path for getting one student evaluation
#   add_group_student_path - gets path for adding new group student
#   group_evaluations_path - gets path for getting all group evaluations
#
module EvaluationsHelper
  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting group evaluations
  #   
  # Args:
  #   evaluation (Evaluation) - ApplicationRecord for Evaluation
  #
  def group_evaluations_path(group)
    if current_instructor
      '/instructors/group/' + group.id.to_s + '/evaluations'
    elsif current_student
      '/students/group/' + group.id.to_s + '/evaluations'
    end
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for getting student evaluation
  #   
  # Args:
  #   evaluation (Evaluation) - ApplicationRecord for Evaluation
  #
  def student_evaluation_path(evaluation)
    if current_instructor
      '/instructors/group/' + evaluation.group_id.to_s + '/evaluation/' + evaluation.id.to_s
    elsif current_student
      '/students/group/' + evaluation.group_id.to_s + '/evaluation/' + evaluation.id.to_s
    end   
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for filling student evaluation
  #   
  # Args:
  #   evaluation (Evaluation) - ApplicationRecord for Evaluation
  #
  def fill_student_evaluation_path(group)
    if current_student
      '/students/group/' + group.id.to_s + '/evaluation/fill'
    end    
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets path for creating student evaluation
  #   
  # Args:
  #   evaluation (Evaluation) - ApplicationRecord for Evaluation
  #
  def create_student_evaluation_path(group)
    if current_student    
      '/students/group/' + group.id.to_s + '/evaluation/create'    
    end  
  end
end
