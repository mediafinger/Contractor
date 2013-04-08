class Product < ActiveRecord::Base
  belongs_to  :unit
  has_many    :line_items
  has_many    :projects, :through => :line_items

  before_validation(:on => :create) { self.key = self.key.to_s.parameterize.underscore.to_sym }
  validates :key,     :presence => true, :uniqueness => true  # { :scope => :team }
  validates :price,   :presence => true, :numericality => true
  validates :unit_id, :presence => true
  #TODO: 
  # validate  :unit_exists

  delegate :unit_desc,     :to => :unit,  :prefix => false, :allow_nil => false
  delegate :needs_digits?, :to => :unit,  :prefix => false, :allow_nil => false

  scope :by_key,      -> { order('key ASC') }
  scope :is_active,   -> { where(:active => true) }
  scope :is_archived, -> { where(:active => false) }
end
