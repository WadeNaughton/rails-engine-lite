class Api::V1::MerchantItemsController < ApplicationController

  def index
    render json: ItemSerializer.new()
    require "pry"; binding.pry
  end

end
