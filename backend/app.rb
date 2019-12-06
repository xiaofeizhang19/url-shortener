require 'sinatra/base'
require_relative 'lib/url_shortener'

class UrlManager < Sinatra::Base
  def initialize
    super
    @url_shortener = UrlShortener.new
  end

  get '/:short_url' do
    original_url = @url_shortener.find_original_url(params[:short_url])
    p original_url
    if original_url.nil?
      status 404
      return
    end
    redirect original_url, 301
  end

  post '/' do
    original_url = JSON.parse(request.body.read)["url"]
    short_url = @url_shortener.add(original_url)
    {
      "short_url": "/#{short_url}",
      "url": original_url
    }.to_json
  end

  run if app_file == $0
end