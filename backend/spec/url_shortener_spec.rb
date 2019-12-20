require 'url_shortener'

describe UrlShortener do
  it 'should add new short url and original url to hash' do
    subject.add('http://www.farmdrop.com')
    expect(subject.urls.length).to eq(1)
  end

  it 'should retrieve the original url' do
    short_url = subject.add('http://www.google.co.uk')
    expect(subject.find_original_url(short_url)).to eq('http://www.google.co.uk')
  end

 it 'should add http prefix to url when necessary' do
    short_url = subject.add('www.google.co.uk')
    expect(subject.find_original_url(short_url)).to eq('http://www.google.co.uk')
  end
end
