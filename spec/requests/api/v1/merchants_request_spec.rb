require 'rails_helper'

RSpec.describe 'The merchant API' do
  it "sends a list of merchants" do
    create_list(:merchant, 10)
    get '/api/v1/merchants'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchants[:data].count).to eq(10)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)

    end
  end
  it "can get one merchant by its id" do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_an(String)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_an(String)

  end

  it "sends 404 with bad id" do
      id = create(:merchant).id
      get "/api/v1/merchants/10000000"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

  end

  it "finds one MERCHANT based on search criteria" do
    merchant1 = Merchant.create!(name: 'wade')
    merchant2 = Merchant.create!(name: 'katie')

    get "/api/v1/merchants/find?name=Wad"

      json_response = JSON.parse(response.body, symbolize_names: true)
      merchant = json_response[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
  end

end
