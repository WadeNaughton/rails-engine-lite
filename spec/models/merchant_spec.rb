require 'rails_helper'

RSpec.describe Merchant do
  describe ' relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    it "finds a merchant by name" do
     merchants = create_list(:merchant, 10)
     further_merchant = create(:merchant, name: "Wade")

     expect(Merchant.find_merchant("Wade")).to eq(further_merchant)
    end
  end
end
