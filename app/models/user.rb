class User < ActiveRecord::Base
  # Include those devise modules
  devise :token_authenticatable, :registerable, :rememberable

  #has_many :projects
  #belongs_to  :team
  has_one     :address, :as => :owner, :dependent => :destroy

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true  # { :scope => :team }

  scope :by_name,     order('name ASC')
  scope :is_active,   -> { where(:active => true) }
  scope :is_archived, -> { where(:active => false) }

  after_create :send_confirmation_mail, :if => Proc.new { |u| u.active }


  def activate!
    return self if active

    self.active = true
    self.ensure_authentication_token
    send_activation_confirmation_mail if save!

    self
  end

  def password_required? 
    false   # some devise setting
  end

  def send_activation_confirmation_mail
    UserMailer.activation_confirmation(self).deliver
  end

  def send_confirmation_mail
    UserMailer.signup_confirmation(self).deliver
  end

end