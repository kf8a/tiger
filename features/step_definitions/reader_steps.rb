require File.expand_path('../lib/eml.rb', __FILE__)

Given /^an eml document with read access given to "([^"]*)" in the root element is inserted by "([^"]*)"$/ do |reader, owner|
  @eml =  EML.create
  Nokogiri::XML::Builder.with(@eml.doc) do |xml|
    xml.access {
      xml.allow{
        xml.principal reader
        xml.permission "read"
      }
    }
  end
  @eml.validate.should be_true, 'eml document is not valid'

  resource = RestClient::Resource.new('http://pasta.lternet.edu/gatekeeper/package/eml', :user=>"uid=#{owner},o=LTER,dc=ecoinformatics,dc=org", :password => password)
  @res = resource.post(@eml.to_xml, :content_type => 'application/xml') {|response, request, result| response }
  @res.code.should  == 200
end

Given /^I am logged in as "([^"]*)"$/ do |user|
  @user = user
end

When /^I read the document$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", :password => password)
  @res = resource.get {|response, request, result| response }
  @res.code.should == 200
end

Then /^the result should be "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end
