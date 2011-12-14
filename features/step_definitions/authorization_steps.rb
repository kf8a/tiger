require File.expand_path('../lib/eml.rb', __FILE__)

Given /^an eml document with read access given to "([^"]*)" in the root element is inserted by "([^"]*)"$/ do |reader, owner|
  @eml = EML.create
  @doc = @eml.doc
  @doc.namespace=nil

  builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
    xml.access(:scope => 'document', :order=>"allowFirst", :authSystem=>"knb") {
      xml.allow{
        xml.principal reader
        xml.permission "read"
      }
    }
  end

  access = Nokogiri::XML(builder.to_xml)
  @doc.css('dataset').before(access.root)
  ns = @doc.add_namespace_definition('eml','eml://ecoinformatics.org/eml-2.1.0')
  @doc.namespace=ns

  EML.validate(@doc).should be_true, 'eml document is not valid'

  resource = RestClient::Resource.new('http://pasta.lternet.edu/gatekeeper/package/eml', 
                                      :user=>"uid=#{owner},o=LTER,dc=ecoinformatics,dc=org",
                                      :password => password_for(owner))
  @res = resource.post(@doc.to_xml, :content_type => 'application/xml') {|response, request, result| response }
  @res.code.should  == 200
end

Given /^I read the document as "([^"]*)"$/ do |user|
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", 
                                      :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", 
                                      :password => password_for(user))
  @res = resource.get {|response, request, result| response }
end

When /^I read the document$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}" )
  @res = resource.get {|response, request, result| response }
end
