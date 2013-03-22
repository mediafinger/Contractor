class Address < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true, :touch => true

  validates :owner_id,   :presence => true
  validates :owner_type, :presence => true
end
