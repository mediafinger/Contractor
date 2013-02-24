class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :customer
  has_many :line_items
  has_many :products, :through => :line_items

  validates :customer_id, :name, :presence => true
  delegate  :name, :to => :customer, :prefix => true, :allow_nil => false

  attr_accessible :name, :status, :customer_id
  
  def total_price
    line_items.inject(0) { |sum, item| sum + item.price }
  end
end
