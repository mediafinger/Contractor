class Address < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true, :touch => true

  validates :owner_id,   :presence => true, :uniqueness => { :scope => :owner_type }
  validates :owner_type, :presence => true

  delegate :email, :to => :owner, :prefix => true,  :allow_nil => false
  delegate :name,  :to => :owner, :prefix => true,  :allow_nil => false
end
