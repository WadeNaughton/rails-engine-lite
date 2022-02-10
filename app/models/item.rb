class Item < ApplicationRecord
belongs_to :merchant
validates_presence_of :name
validates_presence_of :description
validates_presence_of :unit_price
validates_presence_of :merchant_id

  def self.find_items(data)
    where("name ILIKE ?", "%#{data}%")
    .order(name: :desc)
  end
end
