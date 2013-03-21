class ProductDecorator < Draper::Decorator
  delegate_all

  def description
    "#{model.key} - #{model.name} || #{price_as_currency} / #{model.unit.humanize}"
  end

  def product_desc
    "#{model.key} | #{model.name}"
  end

  def price_as_currency
    h.number_to_currency(model.price, :precision => 2, :unit => "€", :format => "%n %u")
  end
end
