class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :project
  belongs_to :product

  validates :project_id, :product_id, :units, :presence => true
  validates :units, :numericality => true

  attr_accessible :product_id, :project_id, :units

  delegate :key,            :to => :product,  :prefix => true,  :allow_nil => false
  delegate :name,           :to => :product,  :prefix => true,  :allow_nil => true
  delegate :price,          :to => :product,  :prefix => true,  :allow_nil => false
  delegate :unit,           :to => :product,  :prefix => true,  :allow_nil => false
  delegate :name,           :to => :project,  :prefix => true,  :allow_nil => false
  delegate :customer_name,  :to => :project,  :prefix => false, :allow_nil => true

  def price
    (units * product.price) / 100
  end
end