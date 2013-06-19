class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?  #so varible is available to views

  def current_user

    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?

    !!current_user #!! maks's sure you return bool will not return nil
  end

  def rss_in(feed)  

    require 'open-uri'
    

    case feed
    when '1'
      feed_url = 'http://www.osha.gov/pls/oshaweb/newsRelease.xml'
    when '2'
      feed_url = "http://ohsonline.com/rss-feeds/news.aspx?admgarea=RSS"
    when '3'
      feed_url = 'http://www.csb.gov/rss/news.aspx?CategoryId=9' # new video
    when '4'
      feed_url = 'http://www.csb.gov/rss/news.aspx?CategoryId=8' # safety news
    when '5'
      feed_url = 'http://feeds.feedburner.com/nfpanewsreleases' # nfpa
    else
      feed_url = 'http://www.csb.gov/rss/news.aspx?CategoryId=9' # new video
    end

    rss = SimpleRSS.parse open(feed_url)
    item = 1 + rand(4)
    rss_params = {}
    rss_params[:title] = rss.items[item].title.html_safe
    rss_params[:description] = rss.items[item].description.html_safe
    rss_params[:url] = rss.items[item].link.html_safe
    
    return rss_params

  end
end
