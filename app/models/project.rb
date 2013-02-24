class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :customer
  has_many :line_items
  has_many :products, :through => :line_items
  delegate :name,        :to => :customer, :prefix => true, :allow_nil => true
  #delegate :description, :to => :product,  :prefix => true, :allow_nil => true

  attr_accessible :name, :status, :customer_id, :products
  
  def total_price
    price = 0
    
    line_items.each do |item|
      price += item.price
    end

    price
  end


  def price(product)
    return "DEPRECATED"
  end

  def old_total_price
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

  def old_price(product)
    return (product.price / 100).round(2).to_s + " €"           if product.unit == "project"
    return (product.price * units / 100).round(2).to_s + " €"   if product.unit == "unit"
    return (product.price * 100 - 100).round(2).to_s + " %"     if product.unit == "sum"
  end

end
