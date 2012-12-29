class Customer < ActiveRecord::Base
  attr_accessible :active, :email, :name
end
