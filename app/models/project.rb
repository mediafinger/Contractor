class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product
  attr_accessible :title, :status, :source_language, :target_language, :customer_id, :product_id, :units
  delegate :name, :to => :customer, :prefix => true, :allow_nil => true

  def price
    if units && product_id
      (product.price * units / 100).round(2)
    else
      "n / a"
    end
  end
end
