require 'rails_helper'

RSpec.describe 'The merchant items API' do
  it "sends a list of merchants items" do
    merchant = create(:merchant)
    items = create_list(:item, 10, merchant_id: merchant.id)
    get "/api/v1/merchants/#{merchant.id}/items"
    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchant_items[:data].count).to eq(10)

    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
    end
  end
end
