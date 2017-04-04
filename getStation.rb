require 'uri'
require 'net/http'

params = {"term" => "Дро"}

uri = URI.parse("http://booking.uz.gov.ua/purchase/station/")
uri.query = URI.encode_www_form(params)
response = Net::HTTP.get_response(uri)

puts "Response #{response.code} #{response.message}: #{response.body}"