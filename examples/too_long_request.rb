require 'net/http'
require 'openssl'

http = Net::HTTP.new("request-is-response.herokuapp.com", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
post = Net::HTTP::Post.new("/too_long_request")
puts "begin request " + Time.now.inspect

puts http.get("/too_long_request").inspect
puts "end request " + Time.now.inspect

puts "begin request " + Time.now.inspect
puts http.start {|h| h.request(post) }.inspect
puts "end request " + Time.now.inspect
