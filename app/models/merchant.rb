class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name

  def self.find_merchant(data)
    where("name ILIKE ?", "%#{data}%")
    .order(name: :desc).first
  end
end
