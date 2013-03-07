class Product < ActiveRecord::Base
  belongs_to  :unit
  has_many    :line_items
  has_many    :projects, :through => :line_items

  validates :key,     :presence => true, :uniqueness => true  # { :scope => :team }
  validates :price,   :presence => true, :numericality => true
  validates :unit_id, :presence => true

  delegate :unit_desc,     :to => :unit,  :prefix => false, :allow_nil => false
  delegate :needs_digits?, :to => :unit,  :prefix => false, :allow_nil => false

  scope :by_name, order('key ASC')
end
