class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_to do |format|
      format.html {}
      format.json { render json: @categories; return }
    end

    @countries = Country.countries_list
    respond_to do |format|
      format.html {}
      format.json { render json: @countries; return }
    end
    @user = @current_user
  end

  def show
    @category = Category.find params[:id]
    respond_to do |format|
      format.html {}
      format.json { render json: @category; return }
    end

  end

  def create
    # make sure clear old preference because it is checkbox
    @current_user.categories.clear
    # get values from add my news and find api_id
    params[:pref_category].each do |id|
      category = Category.find_by(:api_id => id)
      @current_user.categories << category
    end
    @current_user.save

    redirect_to users_mynews_path
  end

end

