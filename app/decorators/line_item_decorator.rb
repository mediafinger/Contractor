class LineItemDecorator < Draper::Decorator
  delegate_all

  def price_as_currency(digits = 2)
    format_as_currency(model.price, digits)
  end


  def modified_price_as_currency(digits = 2)
    format_as_currency(model.product_price * model.modification / 100, digits)
  end

  def product_price_as_currency(digits = 2)
    format_as_currency(model.product_price / 100, digits)
  end

  def format_as_currency(number, digits = 2)
    h.number_to_currency(number, :precision => digits, :unit => "€", :format => "%n %u")
  end
end
