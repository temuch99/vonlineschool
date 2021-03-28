class Admin::LessonsController < Admin::AdminController
  before_action :set_course
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def index
    @lessons = @course.lessons.order(position: :asc).page(params[:page])
  end

  def new
    add_breadcrumb "Новый урок", [:new, :admin, @course, :lesson]

    @lesson = @course.lessons.build
    @lesson.text_lections.build if @lesson.text_lections.empty?
  end

  def create
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to [:admin, @course, :lessons], notice: "Урок создан"
    else
      add_breadcrumb "Новый урок", [:new, :admin, @course, :lesson]
      @lesson.text_lections.build if @lesson.text_lections.empty?

      flash.now[:alert] = "Произошла ошибка"
      render 'new'
    end
  end

  def edit
    @lesson.text_lections.build if @lesson.text_lections.empty?
    add_breadcrumb "Редактировать #{@lesson.title}", [:edit, :admin, @course, @lesson]
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to [:admin, @course, :lessons], notice: "Урок обновлен"
    else
      add_breadcrumb "Редактировать #{@lesson.title}", [:edit, :admin, @course, @lesson]
      @lesson.text_lections.build if @lesson.text_lections.empty?

      flash.now[:alert] = "Произошла ошибка"
      render 'edit'
    end
  end

  def destroy
    if @lesson.destroy
      redirect_to [:admin, @course, :lessons], notice: "Урок удален"
    else
      redirect_to [:admin, @course, :lessons], alert: "Не удалось удалить урок"
    end
  end

  private

    def set_course
      @course = Course.find(params[:course_id])

      add_breadcrumb "Курсы", :admin_courses_path
      add_breadcrumb @course.title, [:admin, @course, :lessons]
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_active_header_item
      @header[:courses][:active] = true
    end

    def lesson_params
      params.require(:lesson).permit(:title, :description, :video_lection, :lection_links, :survey_size, 
                                     :section_id, :survey_duration, :attempts, :homework, :survey_end_at,
                                     :homework_end_at, :is_offline_survey,
                                     text_lections_attributes: [:lection, :id, :_destroy, :title])
    end
end
