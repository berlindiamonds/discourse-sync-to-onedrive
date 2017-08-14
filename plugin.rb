# name: discourse-sync-to-skydrive
# about: -
# version: 1.0
# authors: Kaja
# url: https://github.com/berlindiamonds/discourse-sync-to-skydrive

# GEMS
gem 'httparty', '0.15.6', { require: false }
gem 'mimemagic', '0.3.2', { require: false }
gem 'httmultiparty', '0.3.16', { require: false }

gem 'skydrive', '1.2.0'
require 'sidekiq'

enabled_site_setting :discourse_sync_to_skydrive_enabled

after_initialize do
  load File.expand_path("../app/jobs/regular/sync_backups_to_skydrive.rb", __FILE__)
  load File.expand_path("../lib/skydrive_synchronizer.rb", __FILE__)

  Backup.class_eval do
    def after_create_hook
      Jobs.enqueue(:sync_backups_to_skydrive)
    end
  end
end