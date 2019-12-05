require 'sinatra/base'
require_relative 'lib/url_shortener'

class UrlManager < Sinatra::Base
  before do
    @url_shortener = UrlShortener.new
  end
q
  get '/:short_url' do
    # Retrive original url and redirect
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