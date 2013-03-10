class Project < ActiveRecord::Base
  belongs_to  :customer
  belongs_to  :status
  has_many    :line_items
  has_many    :products,  :through => :line_items

  validates :customer_id, :presence => true
  validate  :customer_exists
  validates :name,        :presence => true
  validates :status_id,   :presence => true

  delegate :name,         :to => :customer, :prefix => true,  :allow_nil => false
  delegate :name,         :to => :status,   :prefix => true,  :allow_nil => false
  delegate :status_desc,  :to => :status,   :prefix => false, :allow_nil => false

  scope :by_name,     order("name ASC")
  scope :by_customer, :joins => :customer, :order => "customer.name"
  scope :by_status,   :joins => :status,   :order => "statuses.sorting"
  scope :in_status,   proc { |status| where(:status_id => status) }


  def line_items_sorted_by_product_unit
    LineItemDecorator.decorate_collection(
      line_items.sort_by { |item| item.product_unit }
    )
  end

  def total_price
    line_items.inject(0) { |sum, item| sum + item.price }
  end

  def customer_exists
    begin
      Customer.find(self.customer_id)
    rescue ActiveRecord::RecordNotFound
      errors.add(:customer_id, "entry with customer_id #{self.customer_id} could not be found")
      false
    end
  end
end
