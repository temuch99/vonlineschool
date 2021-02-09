class Admin::DisciplinesController < Admin::AdminController
  add_breadcrumb "Дисциплины", :admin_disciplines_path

  before_action :set_discipline, only: [:edit, :update, :destroy]

  def index
    @disciplines = Discipline.order(id: :desc).page(params[:page])
  end

  def new
    add_breadcrumb "Новая дисциплина", :new_admin_discipline_path

    @discipline = Discipline.new
  end

  def create
    @discipline = Discipline.new(discipline_params)

    if @discipline.save
      redirect_to admin_disciplines_path, notice: "Дисциплина создана"
    else
      add_breadcrumb "Новая дисциплина", :new_admin_discipline_path

      flash.now[:alert] = "Произошла ошибка"
      render 'new'
    end
  end

  def edit
    add_breadcrumb "Редактировать #{@discipline.title}", edit_admin_discipline_path(@discipline)
  end

  def update
    if @discipline.update(discipline_params)
      redirect_to admin_disciplines_path, notice: "Дисциплина обновлена"
    else
      add_breadcrumb "Редактировать #{@discipline.title}", edit_admin_discipline_path(@discipline)

      flash.now[:alert] = "Произошла ошибка"
      render 'edit'
    end
  end

  def destroy
    if @discipline.destroy
      redirect_to admin_disciplines_path, notice: "Дисциплина удалена"
    else
      redirect_to admin_disciplines_path, alert: "Не удалось удалить дисциплину"
    end
  end

  private
    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def set_active_header_item
      @header[:disciplines][:active] = true
    end

    def discipline_params
      params.require(:discipline).permit(:title)
    end
end
