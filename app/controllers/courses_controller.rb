class CoursesController < BaseController
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
end