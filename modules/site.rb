# encoding: UTF-8
require 'sinatra/base'
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
  
end


