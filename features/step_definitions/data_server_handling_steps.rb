Given /^a valid eml document with a redirected url$/ do
  @eml = EML.create
  @doc = @eml.doc

  url = @doc.xpath('//distribution/online/url').first
  url.content = url.content + 'redirect'

  EML.validate(@doc).should be_true, 'eml document is not valid'
end

Given /^a valid eml document where the data server returns a "([^"]*)" error$/ do |status|
  @eml = EML.create
  @doc = @eml.doc

  url = @doc.xpath('//distribution/online/url').first
  url.content = url.content + "status/#{status}"

  EML.validate(@doc).should be_true, 'eml document is not valid'
end

Given /^the data server takes a long time to respond$/ do
  RestClient.post('http://localhost:8080/sleep', 600)
end

