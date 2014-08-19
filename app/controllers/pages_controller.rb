class PagesController < ApplicationController

  def index
    @countries = Country.countries_list
    respond_to do |format|
      format.html {}
      format.js { render json: @countries }
    end

    @categories = Category.all
    respond_to do |format|
      format.html {}
      format.js { render json: @categories }
    end
  end

end
