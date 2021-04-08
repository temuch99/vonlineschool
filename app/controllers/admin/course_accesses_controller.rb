class Admin::CourseAccessesController < Admin::AdminController
  before_action :set_course

  def index
    @accesses = CourseAccess.order(id: :desc).page(params[:page])
    @access = @course.course_accesses.build
  end

  def create
    @access = @course.course_accesses.new(course_params)

    if @access.save
      redirect_to [:admin, @course, :course_accesses], notice: "Доступ предоставлен"
    else
      @access = @course.course_accesses.build
      @accesses = CourseAccess.order(id: :desc).page(params[:page])

      flash.now[:alert] = "Произошла ошибка"
      render 'index'
    end
  end

  def destroy
    @access = CourseAccess.find(params[:id])
    if @access.destroy
      redirect_to [:admin, @course, :course_accesses], notice: "Доступ удален"
    else
      redirect_to [:admin, @course, :course_accesses], alert: "Не удалось удалить доступ"
    end
  end

  def all_access
    @course.users_without_access.each do |u|
      u.course_accesses.create(course_id: @course.id)
    end
    redirect_to [:admin, @course, :course_accesses], notice: "Доступ добавлен"
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_active_header_item
      @header[:courses][:active] = true
    end

    def course_params
      params.require(:course_access).permit(:user_id)
    end
end
