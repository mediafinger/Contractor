class Product < ActiveRecord::Base
  attr_accessible :description, :price, :unit
end
