class Customer < ActiveRecord::Base
  has_many :projects
  attr_accessible :active, :email, :name
end
