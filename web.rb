require 'sinatra'

helpers do
  def request_headers
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end
end

get '/headers' do
  request_headers.inspect
end

get '/' do
  request.inspect
end
