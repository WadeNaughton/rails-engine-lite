require 'rails_helper'

RSpec.describe 'The items API' do
  it "sends a list of items" do
    merchant = create(:merchant)
    items = create_list(:item, 10, merchant_id: merchant.id)
    get '/api/v1/items'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items[:data].count).to eq(10)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

    end
  end

  it "can get one book by its id" do
      merchant = create(:merchant)
      id = create(:item, merchant_id: merchant.id).id
      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_an(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_an(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_an(Float)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)

  end

  it "can create a item" do
    merchant = create(:merchant)

    item_params = ({
                        name: 'test',
                        description: 'this is a test',
                        unit_price: 30.50,
                        merchant_id: merchant.id,

                      })
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
        created_item = Item.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])



  end

  it "can update an existing item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = {name: "This is a test"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])

  end

  it "can delete an item" do
    merchant = Merchant.create!(name: 'wade')
    item1 = merchant.items.create!(name: 'test', description: 'test', unit_price: 1.50)
    item2 = merchant.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)
    expect(Item.count).to eq(2)

     delete "/api/v1/items/#{item1.id}"

     expect(response).to be_successful
     expect(response.status).to eq(204)
     expect(Item.count).to eq(1)
     expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "shows a merchants information by item" do
    merchant1 = Merchant.create!(name: 'wade')
    item1 = merchant1.items.create!(name: 'test', description: 'test', unit_price: 1.50)
    item2 = merchant1.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)

    get "/api/v1/items/#{item1.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchant[:data][:id].to_i).to eq(merchant1.id)
    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)

  end
end
