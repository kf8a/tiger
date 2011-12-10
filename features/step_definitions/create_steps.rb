require File.expand_path('../lib/eml.rb', __FILE__)
require 'nokogiri'
require 'rest_client'

Given /^a valid eml data package$/ do
  @eml = create_eml_document
  validate(@eml).should be_true, 'eml document was not valid'
end

When /^I insert the data package$/ do
  RestClient.log = Logger.new(STDOUT)
  @response = RestClient.post 'http://pasta.lternet.edu/gatekeeper/package/eml', @eml.to_xml, {:user => 'uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', :password => 'S@ltL@ke'}
end

Then /^it succeeds$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^it fails$/ do
    pending # express the regexp above with the code you wish you had
end

Given /^a valid eml data package in the NIS$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I delete the data package$/ do
    pending # express the regexp above with the code you wish you had
end
