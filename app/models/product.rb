class Product < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # This can be removed as Mass-Assignement protection is done with strong-parameters
  attr_accessible :description, :key, :price, :unit
end
