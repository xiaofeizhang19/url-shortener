require 'url_shortener'

describe UrlShortener do
  it 'should add new short url and original url to hash' do
    subject.add('http://www.farmdrop.com')
    expect(subject.urls.length).to eq(1)
  end
end
