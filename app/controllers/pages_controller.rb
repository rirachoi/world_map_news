class PagesController < ApplicationController

  def index
    @countries = Country.countries_list
    respond_to do |format|
      format.html {}
      format.json { render json: @countries; return }
    end

    @categories = Category.all
    respond_to do |format|
      format.html {}
      format.json { render json: @categories; return }
    end
  end

  def about
  end

end
