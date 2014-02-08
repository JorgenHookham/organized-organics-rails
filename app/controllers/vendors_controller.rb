class VendorsController < ApplicationController
  def new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    @vendor.save
    redirect_to @vendor
  end

  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render :json => @vendor.to_json()}
    end
  end

  def index
    @vendors = Vendor.all

    respond_to do |format|
      format.html
      format.json {render :json => @vendors.to_json()}
    end
  end

  private
    def vendor_params
      params.require(:vendor).permit(:name, :address)
    end
end
