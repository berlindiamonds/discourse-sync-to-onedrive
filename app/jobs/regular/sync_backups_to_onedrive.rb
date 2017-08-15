module Jobs
  class SyncBackupsToOnedrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      backups = Backup.all.take(SiteSetting.discourse_sync_to_onedrive_quantity)
      backups.each do |backup|
        DiscourseBackupToOnedrive::OnedriveSynchronizer.new(backup).sync
      end
      DiscourseBackupToOnedrive::OnedriveSynchronizer.new(backups).delete_old_files
    end
  end
end