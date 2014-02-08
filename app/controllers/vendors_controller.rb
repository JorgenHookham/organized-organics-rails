class VendorsController < ApplicationController
  def new
  end

  def create
    render text: params[:vendor].inspect
  end
end
