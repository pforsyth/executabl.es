# encoding: UTF-8
require 'sinatra/base'
require 'twitter'
require 'json'

class Site < Sinatra::Base
  set :root, Proc.new { File.join(File.dirname(__FILE__),'site' )}
  set :public_folder, Proc.new { File.join(File.dirname(__FILE__),'..', "public") }
  before '*' do
    @title = "Site"
  end
  get '/' do
    haml :main, :layout => true
  end

  get '/projects' do
    haml :projects, :layout => true
  end

  get '/about' do
    haml :about, :layout => true
  end
  
  get '/tweets.json' do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
    end
    tweets = client.user_timeline('paulforsyth', :count => 5)
    json = tweets.collect {|t| t.to_h}
    content_type :json
    json.to_json
  end
  
end
