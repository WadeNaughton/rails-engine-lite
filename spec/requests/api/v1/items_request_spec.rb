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

  it "returns 404 with bad id for search" do
      merchant = create(:merchant)
      id = create(:item, merchant_id: merchant.id).id
      get "/api/v1/items/1000000000"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
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

  it "render 404 when bad params are entered during creation" do
    merchant = create(:merchant)

    item_params = ({
                        name: 'test',
                        description: 'this is a test',
                        merchant_id: merchant.id,

                      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
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

  it "renders 404 when incorrect id is given" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = {name: "This is a test", merchant_id: 1000000}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item)
    expect(response.status).to eq(404)
  end
  it "renders 404 when incorrect id is string" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = {name: "This is a test", merchant_id: "1"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item)
    expect(response.status).to eq(404)
  end

  it "can delete an item" do
    merchant = Merchant.create!(name: 'wade')
    item1 = merchant.items.create!(name: 'test', description: 'test', unit_price: 1.50)
    item2 = merchant.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)
    expect(Item.count).to eq(2)

     delete "/api/v1/items/#{item1.id}"
 #item1.reload
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

  it "returns all items by search criteria" do
    merchant1 = Merchant.create!(name: 'wade')
    item1 = merchant1.items.create!(name: 'test', description: 'test', unit_price: 1.50)
    item2 = merchant1.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)
    item3 = merchant1.items.create!(name: 'tester', description: 'testing', unit_price: 2.50)
    item4 = merchant1.items.create!(name: 'zzzzz', description: 'zzz', unit_price: 2.50)

    get "/api/v1/items/find_all?name=test"

    json_response = JSON.parse(response.body, symbolize_names: true)
    items = json_response[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.count).to eq(3)

    items.each do |item|

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
end
