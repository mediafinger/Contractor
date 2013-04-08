class Customer < ActiveRecord::Base
  has_many :projects
  has_one  :address, :as => :owner, :dependent => :destroy

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true  # { :scope => :team }

  scope :by_name,     -> { order('name ASC') }
  scope :is_active,   -> { where(:active => true) }
  scope :is_archived, -> { where(:active => false) }
end
