class Teachers::CoursesController < DashboardController
  before_action :load_course, except: [:index, :new, :create]
  before_action :load_category, except: [:index, :show, :destroy]

  def index
    @courses = Course.by_author(current_user.id).recent.page(params[:page])
      .per Settings.per_page.teachers.course
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to teachers_courses_path
    else
      render :new
    end
  end

  def show
    @course = Course.find_by id: params[:id]
    respond_to do |format|
      format.html{render partial: "details_information", local: {course: @course}}
    end
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to teachers_courses_path
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to teachers_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:category_id, :name, :description, :image)
      .merge! owner_id: current_user.id
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end

  def load_category
    @categories = Category.all
  end
end