class Status < ActiveRecord::Base
  has_many :projects

  validates :key,     :presence => true, :uniqueness => true  # { :scope => :team }
  validates :name,    :presence => true
  validates :sorting, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }

  scope :by_order, order('sorting ASC')

  def status_desc
    "#{sorting}. #{name} | #{key}"
  end
end