class Status < ActiveRecord::Base
  has_many :projects

  before_validation(:on => :create) { self.key = self.key.to_s.parameterize.underscore.to_sym }
  validates :key,     :presence => true, :uniqueness => true  # { :scope => :team }
  validates :name,    :presence => true
  validates :sorting, :presence => true, :uniqueness => true, # { :scope => :team }
                        :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }

  scope :by_order, order('sorting ASC')


  def status_desc
    "#{sorting}. #{name} | #{key}"
  end
end