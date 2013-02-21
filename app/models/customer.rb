class Customer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :projects
  validates :name, :presence => true

  # This can be removed as Mass-Assignement protection is done with strong-parameters
  attr_accessible :active, :email, :name
end
