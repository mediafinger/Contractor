class Project < ActiveRecord::Base
  belongs_to :customer

  attr_accessible :title, :status, :target_language, :customer_id
end
