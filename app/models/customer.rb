class Customer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :projects
  validates :name, :presence => true
  validates :email, :uniqueness => true  # { :scope => :team }

  attr_accessible :active, :email, :name
end
