class Admin::CoursesController < Admin::AdminController
  add_breadcrumb "Курсы", :admin_courses_path

  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.order(id: :desc).page(params[:page])
  end

  def new
    add_breadcrumb "Новый курс", :new_admin_course_path

    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_path, notice: "Курс создан"
    else
      add_breadcrumb "Новый курс", :new_admin_course_path

      flash.now[:alert] = "Произошла ошибка"
      render 'new'
    end
  end

  def edit
    add_breadcrumb "Редактировать #{@course.title}", edit_admin_course_path(@course)
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: "Курс обновлен"
    else
      add_breadcrumb "Редактировать #{@course.title}", edit_admin_course_path(@course)

      flash.now[:alert] = "Произошла ошибка"
      render 'edit'
    end
  end

  def destroy
    if @course.destroy
      redirect_to admin_courses_path, notice: "Курс удален"
    else
      redirect_to admin_courses_path, alert: "Не удалось удалить курс"
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def set_active_header_item
      @header[:courses][:active] = true
    end

    def course_params
      params.require(:course).permit(:title, :description, :image)
    end
end
