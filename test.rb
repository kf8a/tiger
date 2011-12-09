require 'nokogiri'
communication = '<communication>
 <document><data>xxx</data></document>
 </communication>'

doc = Nokogiri::XML(communication)
puts doc.to_xml
cost = 4
Nokogiri::XML::Builder.with(doc.at('communication')) do |xml|
  xml.credit("value" => cost)
end
puts doc.to_xml
doc.search('//document/data').each do |node|
  node.remove
end
puts doc.to_xml
