class PagesController < ApplicationController
  def index
    @countries = Country.countries_list
    @country_names = [];
   # Country.countries_list.each {|c| @country_names << c[:name].to_s}

    respond_to do |format|
      format.html {}
      format.js { render json: @countries }
    end
  end
end
