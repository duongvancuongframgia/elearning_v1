class Admins::CategoriesController < DashboardController
  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.recent.page(params[:page])
      .per Settings.per_page.admins.category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to admins_categories_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by id: params[:id]
    respond_to do |format|
      format.html{render partial: "details_information", local: {category: @category}}
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to admins_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to admins_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = t "dashboard.users.not_found"
    redirect_to admins_categories_path
  end
end