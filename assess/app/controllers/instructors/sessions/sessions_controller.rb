# frozen_string_literal: true

class Instructors::Sessions::SessionsController < Devise::SessionsController
  before_action :check_instructor, only: [:dashboard]
  before_action :configure_sign_in_params, only: [:create]

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
    @instructor = current_instructor
    @sections = Section.where instructor_id: @instructor.id
  end

  # The path used after sign in.
  def after_sign_in_path_for(resource)
    instructor_dashboard_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def check_instructor
    if !current_instructor
      redirect_to :root, notice: "You are not logged in as instructor"
    end  
  end
end
