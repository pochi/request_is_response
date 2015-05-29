require 'sinatra'

set :public_dir, File.dirname(__FILE__) + "/public"
set :views, File.dirname(__FILE__) + "/view"

=begin
if you want to auth all pages, this part set available.
use Rack::Auth::Basic do |username, password|
  username == "request" && password == "response"
end
=end


helpers do
  def request_headers
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end

  def authenticate!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized¥n"])
    end
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['request', 'response']
  end
end

get '/headers' do
  request_headers.inspect
end

get '/' do
  @request_headers = request_headers.merge(params)
  haml :index
end

get '/authenticate' do
  authenticate!
  @request_headers = request_headers.merge(params)
  haml :index
end

get '/authenticate/sub' do
  authenticate!
  @request_headers = request_headers.merge(params)
  haml :index
end

post '/too_long_request' do
  sleep 120
  haml :index
end

get '/too_long_request' do
  sleep 120
  haml :index
end


post '/' do
  @request_headers = request_headers.merge(params)
  haml :index
end
