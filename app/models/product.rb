class Product < ActiveRecord::Base
  attr_accessible :description, :key, :price, :unit
end
