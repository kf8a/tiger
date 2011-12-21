Given /^a valid eml document$/ do
  @eml = EML.create
  @doc = @eml.doc
  EML.validate(@doc).should be_true, 'eml document is not valid'
end

When /^I insert the document into the NIS$/ do
  resource = RestClient::Resource.new('http://pasta.lternet.edu/gatekeeper/package/eml', 
                                      :user=>"uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org", 
                                      :password => password_for('ucarroll'))
  @res = resource.post(@doc.to_xml, :content_type => 'application/xml') {|response, request, result| response }
end

Given /^a data file and valid eml document with a timestamp of "([^"]*)" and a format of "([^"]*)"$/ do |timestamp, format|
  @eml = EML.create
  @doc = @eml.doc_with_modified_css('attribute') do
    Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.attribute {
        xml.attributeName 'first column'
        xml.attributeDefinition 'the first column'
        xml.measurementScale {
          xml.dateTime {
            xml.formatString format
          }
        }
      }
    end
  end

  EML.validate(@doc).should be_true, 'eml document is not valid'

  RestClient.post('http://localhost:8080/', timestamp)
end
