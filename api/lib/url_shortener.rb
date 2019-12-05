class UrlShortener
  attr_reader :urls

  CHARS = Array('a'..'z') + Array('A'..'Z') + Array('0'..'9')
  def initialize
    @urls = {}
  end

  def add(original_url)
    short_url = generate_short_url
    @urls[short_url] = original_url
  end

  def find_original_url(short_url)
    @urls[short_url]
  end

  private
  def generate_short_url
    Array.new(6) { CHARS.sample }.join
  end
end
