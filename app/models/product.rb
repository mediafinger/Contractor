class Product < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  validates :key, :price, :unit, :presence => true
  validates :key,   :uniqueness => true  # { :scope => :team }
  validates :price, :numericality => true

  has_many :line_items
  has_many :projects, :through => :line_items

  # This can be removed as Mass-Assignement protection is done with strong-parameters
  attr_accessible :active, :key, :name, :price, :unit
end
