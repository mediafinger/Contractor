class Project < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :title, :status, :source_language, :target_language, :customer_id
  delegate :name, :to => :customer, :prefix => true, :allow_nil => true
end
