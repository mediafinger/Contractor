class Unit < ActiveRecord::Base
  validates :key,  :presence => true, :uniqueness => true  # { :scope => :team }
  validates :name, :plural, :presence => true

  scope :by_name, order('name ASC')

  def unit_desc
    "#{name} | #{key}"
  end

  def needs_digits?
    float?
  end
end