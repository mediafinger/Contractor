class Unit < ActiveRecord::Base
  before_validation(:on => :create) { self.key = self.key.to_s.parameterize.underscore.to_sym }
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