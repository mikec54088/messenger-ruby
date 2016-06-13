module Messenger
  class Client
    def self.get_user_profile(user_id, access_token = nil)
      JSON.parse(RestClient.get(
        "https://graph.facebook.com/v2.6/#{user_id}?fields=first_name,last_name,profile_pic \
        &access_token=#{access_token || Messenger.config.page_access_token}",
      ))
    end

    def self.send(data, access_token = nil)
      RestClient.post(
        "https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token || Messenger.config.page_access_token}",
        data.build.to_json,
        content_type: :json
      )
    rescue RestClient::ExceptionWithResponse => err
      puts "\nFacebook API response from invalid request:\n#{err.response}\n\n"
      err
    end
  end
end
