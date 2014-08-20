class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_to do |format|
      format.html {}
      format.json { render json: @categories; return }
    end
  end

  def show
    @category = Category.find params[:id]
    respond_to do |format|
      format.html {}
      format.json { render json: @category; return }
    end
  end
end

