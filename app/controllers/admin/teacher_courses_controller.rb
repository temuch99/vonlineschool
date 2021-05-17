class Admin::TeacherCoursesController < Admin::AdminController
  before_action :set_course
  before_action :can_teacher_course_access

  def index
    @teachers = @course.teachers
  end

  def create
    @priv = @course.teachers_courses.new(user_id: teacher_params[:ids])

    if @priv.save
      redirect_to [:admin, @course, :teacher_courses], notice: "Преподаватель добавлен"
    else
      @teachers = @course.teachers

      flash.now[:alert] = "Произошла ошибка"
      render 'index'
    end
  end

  def destroy
    @priv = TeachersCourse.find_by(user_id: params[:id], course_id: @course.id)
    if @priv.destroy
      redirect_to [:admin, @course, :teacher_courses], notice: "Доступ удален"
    else
      redirect_to [:admin, @course, :teacher_courses], alert: "Не удалось удалить доступ"
    end
  end

  private
  def set_active_header_item
    @header[:courses][:active] = true
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def teacher_params
    params.require(:teachers).permit(:ids)
  end

  def my_courses
    if current_user.roles.exists?(name: :admin)
      Course.all
    else
      current_user.teacher_courses
    end
  end

  def can_teacher_course_access
    unless my_courses.include?(@course)
      redirect_to admin_courses_path, notice: "У вас нет доступа"
    end
  end
end
