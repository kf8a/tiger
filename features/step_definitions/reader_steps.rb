require 'nokogiri'
def create_eml_document
  random = Random.new()
  eml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
    xml.eml("xmlns:eml" => "eml://ecoinformatics.org/eml-2.1.0", 
            "packageId" => "knb-lter-kbs-#{random.rand(1..10000)}.#{random.rand(1..10000)}",
            "system" => "knb",
            "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", 
            "xsi:schemaLocation"=>"eml://ecoinformatics.org/eml-2.1.0 https://nis.lternet.edu/nis/schemas/eml/eml-2.1.0/eml.xsd") {
      xml.parent.namespace = xml.parent.namespace_definitions.find{|ns|ns.prefix=="eml"}
    }
  end
  Nokogiri::XML(eml.to_xml)
end

Given /^an eml document with read access given to "([^"]*)" in the root element is inserted by "([^"]*)"$/ do |reader, owner|
  eml = create_eml_document
  Nokogiri::XML::Builder.with(eml.root) do |xml|
    xml.access {
      xml.allow{
        xml.principal reader
        xml.permission "read"
      }
    }
  end
  puts eml.to_xml

    pending # express the regexp above with the code you wish you had
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
