ENV['APP_ENV'] = 'test'

require './app'
require 'rspec'
require 'json'
require 'rack/test'

RSpec.describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    app = UrlManager.new
    builder = Rack::Builder.new
    builder.run app
  end

  it "shortens url when asked" do
    original_url = "http://www.somewhere.com"
    post(
      "/", 
      {"url": original_url}.to_json, 
      { 'CONTENT_TYPE' => 'application/json' },
    )
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["url"]).to eq(original_url)
    expect(body["short_url"]).to start_with("/")
  end

  it "returns 404 when asked for unknown short url" do
    get "/unknown_short_url"
    expect(last_response.status).to eq(404)
  end

  it "redirects to correct url when given short url" do
    original_url = "http://www.somewhere.com"
    post(
      "/", 
      {"url": original_url}.to_json, 
      { 'CONTENT_TYPE' => 'application/json' },
    )
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    short_url = body["short_url"]

    get short_url
    expect(last_response.status).to be(301)
    expect(last_response.location).to eq(original_url)
  end

  it "returns 400 when given an invalid json request" do
    post(
      "/",
      "url",
      { 'CONTENT_TYPE' => 'application/json' },
    )
    expect(last_response.status).to be(400)
  end
end