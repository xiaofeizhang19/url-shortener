require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'
require_relative 'lib/url_shortener'

class UrlManager < Sinatra::Base
  FE_URL = "http://localhost:3000"

  configure do
    enable :cross_origin
  end

  before do
    response.headers["Access-Control-Allow-Origin"] = FE_URL
  end
  
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, "\
      "X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    response.headers["Access-Control-Allow-Origin"] = FE_URL
    200
  end
  
  def initialize
    super
    @url_shortener = UrlShortener.new
  end

  get '/:short_url' do
    short_url = params[:short_url]
    original_url = @url_shortener.find_original_url(short_url)
    if original_url.nil?
      status 404
      return
    end
    @url_shortener.urls[short_url][:counter] += 1
    redirect original_url, 301
  end

  post '/' do
    request_body = request.body.read
    if !valid_json?(request_body)
      halt 400, {"error": "Invalid Json object"}.to_json
      return
    end
    original_request = JSON.parse(request_body)
    if !original_request.include?("url") || original_request["url"].strip.empty?
      halt 400, {"error": "Invalid request"}.to_json
    else 
      short_url = @url_shortener.add(original_request["url"])
      {
        "short_url": "/#{short_url}",
        "url": original_request["url"]
      }.to_json
    end
  end

  def valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
end

  run if app_file == $0
end