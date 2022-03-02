require 'dotenv/load'
require 'twitter'
require 'functions_framework'

class Main
  def self.run
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    t = Time.now
    wday = [nil, '月', '火', '水', '木', '金', nil][t.wday]
    if wday
      3.times do |i|
        ymdh = t.year * 1_000_000 + t.month * 10_000 + t.day * 100 + i + 18
        @client.update "TBSラジオ アフター6ジャンクション #{t.year}年#{t.month}月#{t.day}日 #{wday}曜日 #{i + 1}枠目 radiko タイムフリー https://radiko.jp/share/?sid=TBS&t=#{ymdh}0000"
        puts 'ツイートしました'
      end
    end
  end
end

FunctionsFramework.cloud_event 'tweet_links' do |_event|
  Main.run
end
