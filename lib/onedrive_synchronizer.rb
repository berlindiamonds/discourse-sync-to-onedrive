module DiscourseBackupToOnedrive
  class OnedriveSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on = SiteSetting.discourse_sync_to_onedrive_enabled
      @api_key = SiteSetting.discourse_sync_to_onedrive_api_key
    end

    def sky
      @sky ||= oauth_client = Onedrive::Oauth::Client.new(@api_key, "your_client_secret", "http://yourcallbackurl", "wl.skydrive_update,wl.offline_access")
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


# redirect user to auth_url = oauth_client.authorize_url
# afterwards will be redirected to the callback url with a 'code' parameter.
# Extract this code and get the access token by invoking the following method
# access_token = oauth_client.get_access_token("the_extracted_code")
# if client instantiated, might need a refresh token
# access_token = oauth_client.get_access_token_from_hash("access_token",
# {:refresh_token => "refresh_token", :expires_at => 1234567})
# client = Skydrive::Client.new(access_token)
# user's home folder: folder = client.my_skydrive
# => Skydrive::Folder object
#