module Jobs
  class SyncBackupsToSkydrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      backups = Backup.all.take(SiteSetting.discourse_sync_to_skydrive_quantity)
      backups.each do |backup|
        DiscourseBackupToSkydrive::SkydriveSynchronizer.new(backup).sync
      end
      DiscourseBackupToSkydrive::SkydriveSynchronizer.new(backups).delete_old_files
    end
  end
end