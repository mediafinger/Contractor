class Unit < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection  

  validates :key,  :presence => true, :uniqueness => true  # { :scope => :team }
  validates :name, :plural, :presence => true

  attr_accessible :active, :float, :key, :name, :plural

  scope :by_name, order('name ASC')

  def unit_desc
    "#{name} | #{key}"
  end

  def needs_digits?
    float?
  end
end