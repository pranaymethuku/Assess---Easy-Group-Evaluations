# Created by: Pranay Methuku 7/24
#
# Controller for managing evaluations of a student
#
# Functions: 
#   index - shows all evaluations of a group/student
#   show - shows one evaluation of a student
#   new - gets a form for a new evaluation of a student
#   edit - gets a form for editing a evaluation of a student
#   create - creates a evaluation for a student
#   update - updates a evaluation for a student
#   destroy - deletes a evaluation of a student
#   
#   set_evaluation - before action for getting individual evaluation
#   evaluation_params - retrieves parameters related to a evaluation from the url
#   check_instructor - before action to check if instructor is logged in 
#   check_instructor_or_student - before action to check if either an instructor 
#     or student is logged in 
#

class EvaluationsController < ApplicationController
  before_action :check_instructor, only: [:destroy]
  before_action :check_student, only: [:new, :create, :edit, :update]
  before_action :check_instructor_or_student, only: [:index, :show]
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]

  # Created by: Pranay Methuku 7/24
  #
  # shows all evaluations of a group/student
  # GET /instructors/group/:group_id/evaluations
  #
  def index
    @group = Group.find params[:group_id]
    if current_instructor
      @evaluations = Evaluation.where group_id: @group.id
    elsif current_student
      @evaluations = Evaluation.where group_id: @group.id, student_id: current_student.id
    end
  end

  # Created by: Pranay Methuku 7/24
  #
  # shows one evaluation for a student
  # GET /instructors/group/:group_id/evaluation/:id
  # GET /students/group/:group_id/evaluation/:id
  #
  def show
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets a form for a new evaluation for a student
  # GET /students/group/:group_id/evaluation/new
  #
  def new
    @evaluation = Evaluation.new
    @group = Group.find params[:group_id]
  end

  # Created by: Pranay Methuku 7/24
  #
  # gets a form for editing a evaluation for a student
  #   no route currently
  #
  def edit
  end

  # Created by: Pranay Methuku 7/24
  #
  # creates a evaluation for a student
  # POST /students/group/:group_id/evaluation/create
  #
  def create
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.group_id = params[:group_id]
    @evaluation.student_id = current_student.id
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to student_dashboard_path, notice: 'Evaluation was successfully created.' }
        format.json { render :show, status: :created, location: student_dashboard_path }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/24
  #
  # updates a evaluation for a student
  #   no route currently
  #
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/24
  #
  # deletes a group from a section
  #   no route currently
  #
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.permit(:date_completed,:purpose ,:contribution, :team_contribution, :managers, :manager_performance, :outstanding_participation, :poor_participation, :other)
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
    # before action to check if student is logged in
    #
    def check_student
      if !current_student
        redirect_to :root, notice: "You are not logged in as student"
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
