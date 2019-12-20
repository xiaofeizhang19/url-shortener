class UrlShortener
  attr_reader :urls

  CHARS = Array('a'..'z') + Array('A'..'Z') + Array('0'..'9')

  def initialize
    @urls = {}
  end

  def add(original_url)
    url = add_http_prefix_if_needed(original_url)
    short_url = generate_unique_short_url
    @urls[short_url] = {
      original_url: url,
      counter: 0
    }
    short_url
  end

  def find_original_url(short_url)
    @urls[short_url][:original_url] unless @urls[short_url].nil?
  end

  private
  def add_http_prefix_if_needed(url)
    url = "http://#{url}" unless url.start_with?('http://', 'https://')
    url
  end

  def generate_short_url
    Array.new(6) { CHARS.sample }.join
  end

  def generate_unique_short_url
    short_url = generate_short_url
    while @urls.include? short_url
      short_url = generate_short_url
    end
    short_url
  end
end
