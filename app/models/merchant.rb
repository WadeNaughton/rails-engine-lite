class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :name


#use group before select
  def self.top_merchants_by_revenue(number)
    joins(invoices: {invoice_items: :transactions})
    .where(transactions: { result: "success"}, invoices: { status: 'shipped'})
    .group(:id)
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity)as total_revenue")
    .order(total_revenue: :desc)
    .limit(number)
  end

  def total_revenue
       invoices.joins(invoice_items: :transactions)
      .where(transactions: { result: "success"}, invoices: { status: 'shipped'})
      .select("invoices.*, SUM(invoice_items.unit_price * invoice_items.quantity)as total_revenue")
      .group(:id)
      .sum(&:total_revenue)
  end

  def self.most_items_sold(number)
    joins(invoices: {invoice_items: :transactions})
    .where(transactions: { result: "success"}, invoices: { status: 'shipped'})
    .select('merchants.*, SUM(invoice_items.quantity) AS total_items_sold')
    .group(:id)
    .order(total_items_sold: :desc)
    .limit(number)
  end

  def self.find_merchant(data)
     where("name ILIKE ?", "%#{data}%")
     .order(name: :desc).first
  end

end
