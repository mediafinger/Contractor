class Product < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :line_items
  has_many :projects, :through => :line_items

  validates :key,   :presence => true, :uniqueness => true  # { :scope => :team }
  validates :price, :presence => true, :numericality => true
  validates :unit,  :presence => true 

  attr_accessible :active, :key, :name, :price, :unit
end
