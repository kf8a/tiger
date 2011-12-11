require File.expand_path('../lib/eml.rb', __FILE__)
require 'nokogiri'
require 'rest_client'

Given /^a valid eml data package$/ do
  @eml = EML.create
  @eml.validate.should be_true, 'eml document is not valid'
end

When /^I insert the data package$/ do
  resource = RestClient::Resource.new('http://pasta.lternet.edu/gatekeeper/package/eml', :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', :password => 'S@ltL@ke')
  @res = resource.post(@eml.to_xml, :content_type => 'application/xml') {|response, request, result| response }
end

Then /^it succeeds$/ do
  @res.code.should == 200
end

Then /^it fails due to a conflict$/ do
  @res.code.should == 409
end

Given /^a valid eml data package in the NIS$/ do
  @eml = EML.create
  @eml.validate.should be_true, 'eml document is not valid'
  resource = RestClient::Resource.new('http://pasta.lternet.edu/gatekeeper/package/eml', :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', :password => 'S@ltL@ke')
  @res = resource.post(@eml.to_xml, :content_type => 'application/xml') {|response, request, result| response }
end

When /^I delete the data package$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.identifier}/#{@eml.id}", 
                                      :user=>'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', :password => 'S@ltL@ke')
  @res = resource.delete
end

Given /^a valid eml data package with a scope of "([^"]*)"$/ do |identifier|
  @eml = EML.create( { :identifier=>identifier} )
  @eml.validate.should be_true, 'eml document is not valid'
end

Then /^it fails with a server error$/ do
  @res.code.should == 500
end
