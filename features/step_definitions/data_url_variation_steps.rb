Given /^a valid eml document with an informational data url$/ do
  @eml = EML.create
  @doc = @eml.doc

  url = @doc.xpath('//distribution/online/url').first
  url['function']='information'

  EML.validate(@doc).should be_true, 'eml document is not valid'

  RestClient.post('http://localhost:8080/', '<html><body>This is some info on how to get a the data</body></html>')
end

Given /^a valid eml document with a download data url$/ do
  @eml = EML.create
  @doc = @eml.doc

  url = @doc.xpath('//distribution/online/url').first
  url['function']='download'

  EML.validate(@doc).should be_true, 'eml document is not valid'

  RestClient.post('http://localhost:8080/', '<html><body>This is some info, that might be used,  on how to get a the data</body></html>')
end

Given /^a valid eml document with inline data$/ do
  @eml = EML.create
  @doc = @eml.doc_with_modified_xpath('//distribution') do
    Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.distribution{
        xml.inline 1
      }
    end
  end

  EML.validate(@doc).should be_true, 'eml document is not valid'
end

Given /^a valid eml document with offline data$/ do
  @eml = EML.create
  @doc = @eml.doc_with_modified_xpath('//distribution') do 
    Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.distribution{
        xml.offline {
          xml.mediumName 'various notes scattered about'
        }
      }
    end
  end

  EML.validate(@doc).should be_true, 'eml document is not valid'
end

Then /^the document is not in the NIS$/ do
    pending # express the regexp above with the code you wish you had
end
