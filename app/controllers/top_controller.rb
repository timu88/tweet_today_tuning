class TopController < ApplicationController
  skip_before_action :authenticate

  list_tuning = ["Regular", "Half down"]

  def index
  end

  def tweet
    if signed_in?
      client = Twitter::REST::Client.new do |config|
        # applicationの設定
        config.consumer_key         = Settings.twitter_key
        config.consumer_secret      = Settings.twitter_secret
        # ユーザー情報の設定
        user_auth = current_user.authentications.first
        config.access_token         = user_auth.token
        config.access_token_secret  = user_auth.secret

        client.update(list_tuning[0])

        redirect_to root_path, notice: "ツイートしました"

        #まだログインしてなかったときはどうするか
        #rescueで対応？
      end
    end
  end
end
