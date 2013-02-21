# encoding: UTF-8

class Project < ActiveRecord::Base
  belongs_to :customer
  has_and_belongs_to_many :products
  attr_accessible :title, :status, :source_language, :target_language, :customer_id, :units, :products
  delegate :name,        :to => :customer, :prefix => true, :allow_nil => true
  #delegate :description, :to => :product,  :prefix => true, :allow_nil => true

  def total_price
    total_price = 0
    pros = products.order(:key)

    pros.each do |product|
      if product.unit == "project"
        total_price += product.price
      elsif product.unit == "unit"
        total_price += product.price * units
      elsif product.unit == "sum"
        total_price *= product.price
      end
    end

    (total_price / 100).round(2)  
  end

  def price(product)
    return (product.price / 100).round(2).to_s + " €"           if product.unit == "project"
    return (product.price * units / 100).round(2).to_s + " €"   if product.unit == "unit"
    return (product.price * 100 - 100).round(2).to_s + " %"           if product.unit == "sum"
  end

end
