class PagesController < ApplicationController

  def index
    @countries = Country.countries_list
    @country_codes = []
    Country.countries_list.each {|c| @country_codes << c[:code].downcase}

    respond_to do |format|
      format.html {}
      format.js { render json: @countries }
    end
  end
end
