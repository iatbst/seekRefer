class RegionPageController < ApplicationController
  def index
    city = params[:city]
    @region = Location.where("name like ?", "%#{city}%" ).first!
    @companies = @region.companies
  end
end
