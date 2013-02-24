class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :project
  belongs_to :product

  validates :project_id, :product_id, :units, :presence => true
  validates :units, :numericality => true

  attr_accessible :product_id, :project_id, :units

  def price
    (units * product.price) / 100
  end
end