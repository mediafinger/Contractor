class Product < ActiveRecord::Base
  belongs_to  :unit
  has_many    :line_items
  has_many    :projects, :through => :line_items

  validates :key,     :presence => true, :uniqueness => true  # { :scope => :team }
  validates :price,   :presence => true, :numericality => true
  validates :unit_id, :presence => true
  #TODO: 
  # validate  :unit_exists

  delegate :unit_desc,     :to => :unit,  :prefix => false, :allow_nil => false
  delegate :needs_digits?, :to => :unit,  :prefix => false, :allow_nil => false

  scope :by_key, order('key ASC')
end
