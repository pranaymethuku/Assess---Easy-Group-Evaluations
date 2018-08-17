# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :check_student, only: [:dashboard, :show_students]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def dashboard
    @student = current_student
    @sections = @student.sections
  end

  def show_students
    @group = Group.find(params[:group_id])
    @students = @group.students
  end

  # The path used after sign in.
  def after_sign_in_path_for(resource)
    student_dashboard_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def check_student
    if !current_student
      redirect_to :root, notice: "You are not logged in as student"
    end  
  end
end
