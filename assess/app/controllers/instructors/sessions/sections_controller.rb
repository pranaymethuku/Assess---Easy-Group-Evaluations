# Created by: Pranay Methuku 7/23
#
# Controller for managing sections for an instructor
#
# Functions: 
#   index - shows all sections for an instructor
#   show - shows one section for an instructor
#   new - gets a form for a new section for an instructor
#   edit - gets a form for editing a section for an instructor
#   create - creates a section for an instructor
#   update - updates a section for an instructor
#   destroy - deletes a section from an instructor's sections
#   
#   set_section - before action for getting individual section
#   section_params - retrieves parameters related to a section from the url
#   check_instructor - before action to check if instructor is logged in 
#

class Instructors::Sessions::SectionsController < ApplicationController
  before_action :check_instructor, only: [:index,:show, :edit, :update , :destroy]
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # Created by: Pranay Methuku 7/23
  #
  # shows all groups in a section
  # GET /instructors/classes
  #
  def index
    @instructor = current_instructor
    @sections = Section.where instructor_id: @instructor.id
  end

  # Created by: Pranay Methuku 7/23
  #
  # shows one section for an instructor
  # GET /instructors/class/:id
  #
  def show
  end

  # Created by: Pranay Methuku 7/23
  #
  # gets a form for a new section for an instructor
  # GET /instructors/class/new
  #
  def new
    @section = Section.new
  end

  # Created by: Pranay Methuku 7/23
  #
  # gets a form for editing a section for an instructor
  #   no route currently
  #
  def edit
    @section = Section.find(params[:id])
  end

  # Created by: Pranay Methuku 7/23
  #
  # creates a section for an instructor
  # POST /instructors/class/create
  #
  def create
    @section = Section.new(section_params)
    @section.instructor_id = current_instructor.id
    respond_to do |format|
      if @section.save
        format.html { redirect_to instructor_dashboard_path, notice: 'Class was successfully created.' }
        format.json { render :show, status: :created, location: instructor_dashboard_path }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # updates a section for an instructor
  #   no route currently
  #
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: 'Class was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # Created by: Pranay Methuku 7/23
  #
  # deletes a section from an instructor's sections
  # DELETE /instructors/class/:id
  #
  def destroy
    @sections = Group.where(section_id: @section.id)
    @sections.each do |section|
      section.destroy
    end
    @section.destroy
    respond_to do |format|
      format.html { redirect_to instructor_classes_path, notice: 'Class was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.fetch(:section, {})
      params.permit(:name, :dept, :number)
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
end
