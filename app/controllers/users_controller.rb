class UsersController < ApplicationController
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
      redirect_to @user
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
      redirect_to root
    end
  end

  def show
    @user = User.find params[:id]
    #render :json => @user
  end

  def destroy
    user = User.find params[:id]
    user.destroy

    redirect_to root
  end

  private
  def users_params
    params.require(:user).permit(:username, :email, :native_country, :native_language, :password, :password_confirmation)
  end
end
