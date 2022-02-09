class Api::V1::SearchController < ApplicationController


  def find

    @merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
                        .order(name: :desc).first
    if @merchant != nil
      render json: MerchantSerializer.new(@merchant)
    else
      render json: { data: { message: "Unable to find Merchant #{params[:name]}"}}
    end
  end
end
