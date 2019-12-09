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
    original_url = @url_shortener.find_original_url(params[:short_url])
    if original_url.nil?
      status 404
      return
    end
    redirect original_url, 301
  end

  post '/' do
    original_url = JSON.parse(request.body.read)["url"]
    if original_url.strip.empty?
      halt 400, {"error": "URL cannot be empty"}.to_json
    else
      short_url = @url_shortener.add(original_url)
      {
        "short_url": "/#{short_url}",
        "url": original_url
      }.to_json
    end
  end

  run if app_file == $0
end