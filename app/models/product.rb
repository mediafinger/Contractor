class Product < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :line_items
  has_many :projects, :through => :line_items

  validates :key,   :presence => true, :uniqueness => true  # { :scope => :team }
  validates :price, :presence => true, :numericality => true
  validates :unit,  :presence => true 

  attr_accessible :active, :key, :name, :price, :unit

  scope :by_name, order('key ASC')
end

# Create a Unit model with the attributes:
# string: key
# string: name
# string: plural
# boolean: float
# Name and Plural will be entered by the user and used to display the Unit in the App and on Invoices
# Float will be used to format the display and to set the :step for the number_field
