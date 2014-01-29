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
      config.consumer_key       = '***REMOVED***'
      config.consumer_secret    = '***REMOVED***'
      config.oauth_token        = '***REMOVED***'
      config.oauth_token_secret = '***REMOVED***'
    end
    tweets = client.user_timeline('paulforsyth', :count => 5)
    json = tweets.collect {|t| t.to_h}
    content_type :json
    json.to_json
  end
  
end


# var o = {};
# o.item = item;
# o.source = item.source;
# o.screen_name = item.from_user || item.user.screen_name;
# 
# o.avatar_url = item.profile_image_url || item.user.profile_image_url;
# o.retweet = typeof(item.retweeted_status) != 'undefined';
# o.tweet_time = parse_date(item.created_at);
# o.join_text = s.join_text == "auto" ? build_auto_join_text(item.text) : s.join_text;
# o.tweet_id = item.id_str;
# o.twitter_base = "http://"+s.twitter_url+"/";
# o.user_url = o.twitter_base+o.screen_name;
# o.tweet_url = o.user_url+"/status/"+o.tweet_id;
# o.reply_url = o.twitter_base+"intent/tweet?in_reply_to="+o.tweet_id;
# o.retweet_url = o.twitter_base+"intent/retweet?tweet_id="+o.tweet_id;
# o.favorite_url = o.twitter_base+"intent/favorite?tweet_id="+o.tweet_id;
# o.retweeted_screen_name = o.retweet && item.retweeted_status.user.screen_name;
# o.tweet_relative_time = relative_time(o.tweet_time);
# o.tweet_raw_text = o.retweet ? ('RT @'+o.retweeted_screen_name+' '+item.retweeted_status.text) : item.text; // avoid '...' in long retweets
# o.tweet_text = $([o.tweet_raw_text]).linkUrl().linkUser().linkHash()[0];
# o.tweet_text_fancy = $([o.tweet_text]).makeHeart().capAwesome().capEpic()[0];
# 
# // Default spans, and pre-formatted blocks for common layouts
# o.user = t('<a class="tweet_user" href="{user_url}">{screen_name}</a>', o);
# o.join = s.join_text ? t(' <span class="tweet_join">{join_text}</span> ', o) : ' ';
# o.avatar = o.avatar_size ?
#   t('<a class="tweet_avatar" href="{user_url}"><img src="{avatar_url}" height="{avatar_size}" width="{avatar_size}" alt="{screen_name}\'s avatar" title="{screen_name}\'s avatar" border="0"/></a>', o) : '';
# o.time = t('<span class="tweet_time"><a href="{tweet_url}" title="view tweet on twitter">{tweet_relative_time}</a></span>', o);
# o.text = t('<div class="tweet_text">{tweet_text_fancy}</div>', o);
# o.reply_action = t('<a class="tweet_action tweet_reply" href="{reply_url}">reply</a>', o);
# o.retweet_action = t('<a class="tweet_action tweet_retweet" href="{retweet_url}">retweet</a>', o);
# o.favorite_action = t('<a class="tweet_action tweet_favorite" href="{favorite_url}">favorite</a>', o);
# return o;
