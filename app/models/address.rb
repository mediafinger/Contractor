class Address < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  #TODO: figure out how to implement this for Rails 4:    , :touch => true
  #HINT: try this gem https://github.com/rails/cache_digests on Rails 3 branch

  validates :owner_id,   :presence => true, :uniqueness => { :scope => :owner_type }
  validates :owner_type, :presence => true

  delegate :email, :to => :owner, :prefix => true,  :allow_nil => false
  delegate :name,  :to => :owner, :prefix => true,  :allow_nil => false
end
