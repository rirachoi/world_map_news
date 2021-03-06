class UsersController < ApplicationController
  before_action :check_if_logged_in, :except => [:new, :create, :contact]
  before_action :check_if_admin, :only => [:index]

  def index
    @users = User.all
    respond_to do |format|
      format.html{}
      format.json { render :json => @users }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create users_params
    if @user.save
      session[:user_id] = @user.id
      authenticate_user
      redirect_to pages_path
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update users_params
    if @user.save
      redirect_to user_path
    else
      redirect_to edit_user_path
    end
  end

  def show
    @user = @current_user

    @user = User.find params[:id]
    respond_to do |format|
      format.html{}
      format.json { render :json => @user }
    end
  end

  def mynews
    @user = @current_user

    @categories = @user.categories
    @countries = Country.countries_list
  end

  def contact
    if @current_user.present?
      @user = @current_user
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to pages_path
  end

  private
  def users_params
    params.require(:user).permit(:username, :email, :native_country, :password, :password_confirmation)
  end
end
