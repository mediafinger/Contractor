class ProjectLog < ActiveRecord::Base
  belongs_to :project

  scope :older_than,      proc { |x| where("project_logs.updated_at < ?", x.days.ago) }
  scope :status_above,    proc { |x| where("status_id > ?", x).joins(:project) }
  scope :status_below,    proc { |x| where("status_id < ?", x).joins(:project) }
  scope :status_changes,  where("status_change < ? OR status_change > ?", 0, 0)
end
