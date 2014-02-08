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
  end

  def index
    @vendors = Vendor.all
  end

  private
    def vendor_params
      params.require(:vendor).permit(:name, :phone, :text)
    end
end
