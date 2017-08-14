module DiscourseBackupToSkydrive
  class SkydriveSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on = SiteSetting.discourse_sync_to_skydrive_enabled
    end

    def can_sync?
      @turned_on && backup.present?
    end

    def delete_old_files
    end

    protected

    def perform_sync

    end

    def file_already_there?(folder_name, filename)
    end
  end
end