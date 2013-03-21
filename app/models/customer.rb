class Customer < ActiveRecord::Base
  has_many :projects

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true  # { :scope => :team }

  scope :by_name, order('name ASC')
end
