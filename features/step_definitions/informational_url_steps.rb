Given /^a valid eml document with an informational data url$/ do
  @eml = EML.create
  @doc = @eml.doc

  url = @doc.xpath('//distribution/online/url').first
  url['function']='information'

  EML.validate(@doc).should be_true, 'eml document is not valid'

  RestClient.post('http://localhost:8080/', 'This is some info on how to get a the data')
end
