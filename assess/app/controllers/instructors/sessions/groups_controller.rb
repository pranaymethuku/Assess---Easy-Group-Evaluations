# Created by: Pranay Methuku 7/23
#
# Controller for managing groups in a certain section
#
# Functions: 
#   index - shows all groups in a section
#   show - shows one group in a section
#   new - gets a form for a new group in a section
#   edit - gets a form for editing a group in a section
#   create - creates a group in a section
#   update - updates a group in a section
#   destroy - deletes a group in a section
#   
#   add_students - gets a form for adding students to a certain group
#   link_students - adds students to a certain group
#   show_students - show students in a certain group
#   remove_student - removes students from a certain group
#   
#   set_group - before action for getting individual group
#   group_params - retrieves parameters related to a group from the url
#   check_instructor - before action to check if instructor is logged in 
#   check_instructor_or_student - before action to check if either an instructor 
#     or student is logged in 
#

class Instructors::Sessions::GroupsController < ApplicationController
  before_action :check_instructor, only: [:new, :create, :show, :edit, :update, :destroy, :add_students, :link_students, :remove_student]
  before_action :check_instructor_or_student, only: [:index, :show_students]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # Created by: Pranay Methuku 7/23
  #
  # shows all groups in a section
  # GET /instructors/class/:section_id/groups
  #
  def index
    @section = Section.find (params[:section_id])
    @groups = Group.where section_id: @section.id
  end

  # Created by: Pranay Methuku 7/23
  #
  # shows one group in a section
  # GET /instructors/class/:section_id/group/:id
  #
  def show
  end

  # Created by: Pranay Methuku 7/23
  #
  # gets a form for a new group in a section
  # GET /instructors/class/:section_id/group/new
  #
  def new
    @section = Section.find params[:section_id]
    @group = Group.new section_id: @section.id
  end

  # Created by: Pranay Methuku 7/23
  #
  # gets a form for editing a group in a section
  #   no route currently
  #
  def edit
    @section = Section.find (params[:section_id])
  end

  # Created by: Pranay Methuku 7/23
  #
  # creates a group in a section
  # POST /instructors/class/:section_id/group/create
  #
  def create
    @group = Group.new(group_params)
    @group.section_id = params[:section_id]
    respond_to do |format|
      if @group.save
        format.html { redirect_to instructor_dashboard_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: instructor_dashboard_path }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # updates a group in a section
  #   no route currently
  #
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # deletes a group from a section
  # DELETE /instructors/class/:section_id/group/:id
  #
  def destroy
    @section = Section.find @group.section_id
    @group.destroy
    respond_to do |format|
      format.html { redirect_to instructor_dashboard_path, notice: 'Group was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # gets a form for adding students to a certain group
  # GET /instructors/group/:group_id/student/new
  #
  def add_students
    @group = Group.find params[:group_id]
    @section = Section.find @group.section_id
  end

  # Created by: Pranay Methuku 7/23
  #
  # adds students to a certain group
  # POST /instructors/group/:group_id/student/link
  #
  def link_students
    @group = Group.find params[:group_id]
    @section = Section.find @group.section_id
    params.permit([:student_emails])
    student_emails = params[:student_emails].split
    unlinked_students = []
    student_emails.each do |student_email|
      student = Student.find_by email: student_email
      if student != nil
        if !student.in? @section.students
          @section.students.push student
        end
        if !student.in? @group.students      
          @group.students.push student
        end
      else
        unlinked_students.push student_email
      end
    end
    respond_to do |format|
      if @group.save
        if !unlinked_students.empty?
          format.html { redirect_to instructor_dashboard_path, 
            notice: 'The following students dont have an account: ' + unlinked_students.join(", ") + '. Everyone else was successfully linked' }
        else
          format.html { redirect_to instructor_dashboard_path, notice: 'Students were successfully linked.' }
        end
        format.json { render :show, status: :created, location: instructor_dashboard_path }
      else
        format.html { render :add_students }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # shows students in a certain group
  # GET /instructors/group/:group_id/students
  #
  def show_students
    @group = Group.find(params[:group_id])
    @students = @group.students
  end

  # Created by: Pranay Methuku 7/23
  #
  # deletes students from a certain group
  # DELETE /instructors/group/:group_id/student/:id/remove
  #
  def remove_student
    @group = Group.find params[:group_id]
    @student = Student.find params[:id]
    @group.students.delete @student
    respond_to do |format|
      format.html { redirect_to instructor_dashboard_path, notice: 'Student was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.fetch(:group, {})
      params.permit([:name])
    end

    # Created by: Pranay Methuku 7/25
    #
    # before action to check if instructor is logged in
    #
    def check_instructor
      if !current_instructor
        redirect_to :root, notice: "You are not logged in as instructor"
      end  
    end

    # Created by: Pranay Methuku 7/25
    #
    # before action to check if either an instructor or student is logged in
    #
    def check_instructor_or_student
      if !current_instructor && !current_student
        redirect_to :root, notice: "You are not logged in as instructor or student"
      end  
    end
end
