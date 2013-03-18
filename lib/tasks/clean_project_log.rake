# TODO
# Run every night to delete all ProjectLog entries
# that are old
# and do not belong to a project in an active status

TOO_OLD_IN_DAYS = 63
LAST_ACTIVE_STATUS = 5

namespace :cron do
  namespace :logs do

    namespace :projects do
      desc "Delete old project log data"
      task :cleanup => :environment do
        puts "#{ProjectLog.count} Project-Log entries exist."
        puts "Deleting old entries of inactive Projects ..."

        ProjectLog.older_than(TOO_OLD_IN_DAYS).status_above(LAST_ACTIVE_STATUS).destroy_all
        
        puts "Done. #{ProjectLog.count} Project-Log entries left."
      end
    end
    
  end
end
