require 'rails_helper'

RSpec.describe 'The merchant items API' do
  it "sends a list of merchants items" do
    merchant1 = Merchant.create!(name: 'wade')
    merchant2 = Merchant.create!(name: 'katie')
    item1 = merchant1.items.create!(name: 'test', description: 'test', unit_price: 1.50)
    item2 = merchant1.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)
    item3 = merchant2.items.create!(name: 'more test', description: 'more test', unit_price: 1.50)
    item4 = merchant2.items.create!(name: 'further testing', description: 'further testing', unit_price: 2.50)
    get "/api/v1/merchants/#{merchant1.id}/items"
    merchant_items = JSON.parse(response.body, symbolize_names: true)
    item = merchant1[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchant_items[:data].count).to eq(2)

    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
  
end
