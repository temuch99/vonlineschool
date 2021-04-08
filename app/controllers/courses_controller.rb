class CoursesController < BaseController
  before_action :authenticate_user!, only: :show
  before_action :can_access, only: :show

  def show
  	@course = Course.find(params[:id])
  end

  def index
  	@courses = Course.all
  end

  private
  def set_active_header_item
  	@header[:courses][:active] = true
  end

  def can_access
    @course = Course.find(params[:id])
    access = current_user.course_accesses.where(course_id: @course.id).count == 0
    redirect_to [:courses], notice: "У Вас нет доступа к этому курсу" if access
  end
end