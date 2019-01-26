class Api::V1::Items::MerchantController < ApplicationController
  def show
    render json: Item.find_by_id(params[:item_id]).merchant
  end
end
