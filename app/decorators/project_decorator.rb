class ProjectDecorator < Draper::Decorator
  delegate_all

  def description
    "#{key} - #{name} || #{price_as_currency} / #{unit.humanize}"
  end

  def total_price_as_currency
    h.number_to_currency(model.total_price, :precision => 2, :unit => "€", :format => "%n %u")
  end
end
