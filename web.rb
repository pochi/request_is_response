require 'sinatra'

set :public_dir, File.dirname(__FILE__) + "/public"
set :views, File.dirname(__FILE__) + "/view"

helpers do
  def request_headers
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end
end

get '/headers' do
  request_headers.inspect
end

get '/' do
  # request.inspect
  puts env.inspect
  @request_headers = request_headers.merge(params)
  haml :index
end

post '/' do
  # request.inspect
  puts env.inspect
  @request_headers = request_headers.merge(params)
  haml :index
end
