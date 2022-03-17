class Item < ApplicationRecord
   belongs_to :merchant
   has_many :invoice_items
   has_many :invoices, through: :invoice_items

   has_many :customers, through: :invoices

   validates_presence_of :name,
                         :description,
                         :unit_price,
                         :merchant_id
                         
  def self.find_items(data)
    where("name ILIKE ?", "%#{data}%")
    .order(name: :desc)
  end
end
