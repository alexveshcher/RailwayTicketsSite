require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class UkrRailway
  def get_stations(term)
    params = {"term" => term}

    uri = URI.parse("http://booking.uz.gov.ua/purchase/station/")
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    JSON.parse(response.body)

  end

  def get_tickets_beetwen_stations(station_id_from, station_id_till, departure_date)
    body = {
    	"another_ec" => "0",
    	"date_dep" => departure_date,
    	"search" => "",
    	"station_id_from" => station_id_from,
    	"station_id_till" => station_id_till,
    	"time_dep" => "00:00",
    	"time_dep_till" => ""
    }

    uri = URI.parse("http://booking.uz.gov.ua/purchase/search/")
    query = URI.encode_www_form(body)

    https = Net::HTTP.new(uri.host,uri.port)

    req = Net::HTTP::Post.new(uri.path, initheader =
    	{'Content-Type' =>'application/x-www-form-urlencoded; charset=utf-8',
    	 'Origin' => 'http://booking.uz.gov.ua',
    	 'GV-Ajax' => '1',
    	 'GV-Screen' => '1920x1080',
    	 'GV-Referer' => 'http://booking.uz.gov.ua/',
    	 'Referer' => 'http://booking.uz.gov.ua/',
    	 'Accept-Encoding' => 'gzip, deflate',
    	 'Accept-Language' => 'uk,ru;q=0.8,en;q=0.6'})

    req.body = query
    res = https.request(req)

    JSON.parse(res.body)
  end

  def get_tickets_for_train(station_id_from, station_id_till, departure_date, train_id, coach_type)
    body = {
      "another_ec" => "0",
      "coach_type" => coach_type,
      "date_dep" => departure_date,
      "model" => 0,
      "round_trip" => 0,
      "station_id_from" => station_id_from,
      "station_id_till" => station_id_till,
      "train" => train_id
    }

    uri = URI.parse("http://booking.uz.gov.ua/purchase/coaches/")
    query = URI.encode_www_form(body)

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

    JSON.parse(res.body)
  end

  def get_tickets_for_coach(station_id_from, station_id_till, departure_date, train_id, coach_type_id, coach_num)
    body = {
      "coach_num" => coach_num,
      "coach_type_id" => coach_type_id,
      "date_dep" => departure_date,
      "scheme_id" => 0,
      "station_id_from" => station_id_from,
      "station_id_till" => station_id_till,
      "train" => train_id
    }

    uri = URI.parse("http://booking.uz.gov.ua/purchase/coach/")
    query = URI.encode_www_form(body)

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

    JSON.parse(res.body)
  end
end

# b = UkrRailway.new
# puts b.get_tickets_beetwen_stations(2218155, 2200001, "15.04.2017")
# puts ""
# puts b.get_tickets_for_train(2218155, 2200001, "1492708560", "050Л", "П")
# puts ""
# puts b.get_tickets_for_coach(2218155, 2200001, "1492708560", "050Л", 4, 12)
