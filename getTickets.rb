require 'uri'
require 'net/http'
require 'net/https'
require 'json'

@toSend = {
	"another_ec" => "0",
	"date_dep" => "15.04.2017",
	"search" => "",
	"station_id_from" => "2218155",
	"station_id_till" => "2200001",
	"time_dep" => "00:00",
	"time_dep_till" => ""
}

uri = URI.parse("http://booking.uz.gov.ua/purchase/search/")
query = URI.encode_www_form(@toSend)

https = Net::HTTP.new(uri.host,uri.port)

req = Net::HTTP::Post.new(uri.path, initheader = 
	{'Content-Type' =>'application/x-www-form-urlencoded',
	 'Origin' => 'http://booking.uz.gov.ua',
	 'GV-Ajax' => '1',
	 'GV-Screen' => '1920x1080',
	 'GV-Referer' => 'http://booking.uz.gov.ua/',
	 'Referer' => 'http://booking.uz.gov.ua/',
	 'Accept-Encoding' => 'gzip, deflate',
	 'Accept-Language' => 'uk,ru;q=0.8,en;q=0.6'})

req.body = query
res = https.request(req)

puts JSON.parse(res.body)
puts "\n===============\n\n"
puts "Response #{res.code} #{res.message}: #{res.body}"