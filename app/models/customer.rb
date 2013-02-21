class Customer < ActiveRecord::Base
  has_many :projects
  attr_accessible :active, :email, :name

  validates :name, :presence => true
end
