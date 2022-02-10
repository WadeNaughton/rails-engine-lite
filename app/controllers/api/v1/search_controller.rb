class Api::V1::SearchController < ApplicationController


  def find

    @merchant = Merchant.find_merchant(params[:name])

    if @merchant != nil
      render json: MerchantSerializer.new(@merchant)
    else
      render json: { data: { message: "Unable to find Merchant"}}
    end
  end

  def find_all
    @items = Item.find_items(params[:name])

    if @items != nil
      render json: ItemSerializer.new(@items)
    else
      render json: { data: { message: "Unable to find items"}}
    end
  end
end
