class Invoice < ActiveRecord::Base

  TYPES = [:offer, :quote, :invoice]

  belongs_to  :project
  has_one     :customer,  :through => :project
  belongs_to  :user

  validates :project_id,  :presence => true
  validates :kind,        :presence => true
  validates_inclusion_of  :kind, :in => TYPES
  validates :user_id,     :presence => true

  scope :by_date_sent,    -> { order("sent ASC") }
  scope :by_date_until,   -> { order("until ASC") }
  scope :by_customer,     lambda { joins(:customer).order("customers.name") }
  scope :is_of_kind,      proc { |type| where(:kind => type) }
  scope :is_waiting,      -> { where("open = ? AND accepted = ?", true,  false) }
  scope :is_closed,       -> { where("open = ? AND accepted = ?", false, false) }
  scope :is_accepted,     -> { where("open = ? AND accepted = ?", true,  true) }
  scope :is_archieved,    -> { where("open = ? AND accepted = ?", false, true) }

  def open_invoices
    # InvoiceDecorator.decorate_collection(invoices.is_invoice.is_open.is_not_accepted.by_date_until)
  end

  def total_price_with_taxes
    project.total_price * tax_modification
  end

  def tax_modification
    permill = customer.address && customer.address.tax_permill
    return 1 unless permill

    1.0 + permill.to_f / 1000
  end

end
