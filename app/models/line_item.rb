class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :product
  belongs_to :project

  validates :modifier,  :numericality => { :only_integer => true, :greater_than_or_equal_to => -100, :less_than_or_equal_to => 100 }
  validates :project_id, :product_id, :units, :presence => true
  validates :units,     :numericality => true

  attr_accessible :product_id, :project_id, :modifier, :units

  delegate :customer_name,  :to => :project,  :prefix => false, :allow_nil => true
  delegate :key,            :to => :product,  :prefix => true,  :allow_nil => false
  delegate :name,           :to => :product,  :prefix => true,  :allow_nil => true
  delegate :name,           :to => :project,  :prefix => true,  :allow_nil => false
  delegate :price,          :to => :product,  :prefix => true,  :allow_nil => false
  delegate :unit,           :to => :product,  :prefix => true,  :allow_nil => false

  def price
    (units * product.price * modification) / 100
  end

  def modification
    (100 + modifier).to_f / 100
  end

  def discounted?
    modifier < 0
  end

  def normal_priced?
    modifier == 0
  end

  def surcharged?
    modifier > 0
  end
end