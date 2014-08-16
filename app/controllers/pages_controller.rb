class PagesController < ApplicationController
  def index
    @countries = Country.get_names
    respond_to do |format|
      format.html {}
      format.js { render json: @countries }
    end
    #["country_code", "culture_code", "display_culture_name", "english_culture_name", "language_code"]
  end
end
