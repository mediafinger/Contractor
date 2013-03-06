class LineItemDecorator < Draper::Decorator
  delegate_all

  def modification_tooltip
    if model.discounted?
      { title: "#{product_price_as_currency(3)} mit Rabatt | #{model.modifier}%" }
    elsif model.surcharged?
      { title: "#{product_price_as_currency(3)} mit Aufschlag | #{model.modifier}%" }
    else
      {}
    end
  end

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

  def format_as_number(number)
    precision = model.needs_digits? ? 3 : 0
    
    h.number_with_precision(number.to_f, :precision => precision, :delimiter => "")
  end

end
