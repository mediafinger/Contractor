class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to  :customer
  has_many    :line_items
  has_many    :products,  :through => :line_items

  validates :customer_id, :presence => true
  validates :name,        :presence => true
  
  attr_accessible :name, :status, :customer, :customer_id

  delegate  :name, :to => :customer, :prefix => true, :allow_nil => false

  def line_items_sorted_by_product_unit
    line_items.sort_by { |item| item.product_unit }
  end

  def total_price
    line_items.inject(0) { |sum, item| sum + item.price }
  end
end
