require File.expand_path('../lib/eml.rb', __FILE__)
require 'nokogiri'
require 'rest_client'

Given /^a valid eml data package$/ do
  @eml = EML.create
  EML.validate(@eml).should be_true, 'eml document is not valid'
end

When /^I insert the data package$/ do
  resource = RestClient::Resource.new('http://pasta.lternet.edu/package/eml', 
                                      :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', 
                                      :password => password_for('ucarroll')) 
  @res = resource.post(@eml.to_xml, :content_type => 'application/xml') {|response, request, result| response }
end

Given /^a valid eml data package in the NIS$/ do
  @eml = EML.create
  EML.validate(@eml).should be_true, 'eml document is not valid'
  resource = RestClient::Resource.new('http://pasta.lternet.edu/package/eml', 
                                      :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', 
                                      :password => password_for('ucarroll'))
  @res = resource.post(@eml.to_xml, :content_type => 'application/xml') {|response, request, result| response }
end

When /^I delete the data package$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/package/eml/#{@eml.identifier}/#{@eml.id}", 
                                      :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', 
                                      :password => password_for('ucarroll'))
  @res = resource.delete
end

Given /^a valid eml data package with a scope of "([^"]*)"$/ do |identifier|
  @eml = EML.create( { :identifier=>identifier} )
  EML.validate(@eml).should be_true, 'eml document is not valid'
end

When /^I upgrade the package to a new version$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I check the revisions$/ do

    pending # express the regexp above with the code you wish you had
end

Then /^I see (\d+) revisions$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end
