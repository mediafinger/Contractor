class User < ActiveRecord::Base
  # Include those devise modules
  devise :token_authenticatable, :registerable, :rememberable

  #has_many :projects
  #belongs_to  :team
  has_one     :address, :as => :owner, :dependent => :destroy

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true  # { :scope => :team }

  scope :by_name,     order('name ASC')
  scope :is_active,   where(:active => true)
  scope :is_archived, where(:active => false)

  def password_required? 
    false   # some devise setting
  end
end