require 'rails_helper'

RSpec.describe Item do
  describe ' relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe ' class methods' do
    it "text" do

      merchant = create(:merchant, name: "Wade")
      items = create_list(:item, 5, merchant_id: merchant.id)
      item1 = merchant.items.create!(name: 'test', description: 'test', unit_price: 1.50)
      item2 = merchant.items.create!(name: 'testing', description: 'testing', unit_price: 2.50)

      expect(Item.find_items("test")).to eq([item2, item1])
    end
  end
end
