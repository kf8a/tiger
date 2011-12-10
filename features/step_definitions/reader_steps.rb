require File.expand_path('../lib/eml.rb', __FILE__)

Given /^an eml document with read access given to "([^"]*)" in the root element is inserted by "([^"]*)"$/ do |reader, owner|
  pending # express the regexp above with the code you wish you had
  eml = create_eml_document
  Nokogiri::XML::Builder.with(eml.root) do |xml|
    xml.access {
      xml.allow{
        xml.principal reader
        xml.permission "read"
      }
    }
  end
end

Given /^I am logged in as "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end

When /^I read the document$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^the result should be "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end
