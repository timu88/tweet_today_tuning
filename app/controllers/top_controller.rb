require 'twitter'
class TopController < ApplicationController
  skip_before_action :authenticate


  def index
  end

  def tweet
      client = Twitter::REST::Client.new do |config|
        list_tuning = ["Regular", "Half step down", "Whole step down", "Half + Whole step down", "Drop D", "Drop C#", "Drop B"]
        # applicationの設定
        config.consumer_key         = Settings.twitter_key
        config.consumer_secret      = Settings.twitter_secret
        # ユーザー情報の設定
        user_auth = current_user.authentications.first
        config.access_token         = user_auth.token
        config.access_token_secret  = user_auth.secret

        idx = rand(list_tuning.size)
        tuning = list_tuning[idx]
        text = %(今日のチューニング: #{tuning} from ruby app)
        config.update(text)

        redirect_to root_path, notice: "ツイートしました"

        #まだログインしてなかったときはどうするか
        #rescueで対応？
    end
  end
end
