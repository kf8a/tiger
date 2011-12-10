require 'nokogiri'

def create_eml_document
  random = Random.new()
  eml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
    xml.eml("xmlns:eml" => "eml://ecoinformatics.org/eml-2.1.0", 
            "packageId" => "knb-lter-kbs-#{random.rand(1..10000)}.#{random.rand(1..10000)}",
            "system" => "knb",
            "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", 
            "xsi:schemaLocation"=>"eml://ecoinformatics.org/eml-2.1.0 https://nis.lternet.edu/nis/schemas/eml/eml-2.1.0/eml.xsd") {
            xml.dataset {
              xml.title 'test dataset'
              xml.creator {
                xml.positionName 'FLS Data Manager'
              }
              xml.contact {
                xml.positionName 'FLS Data Manager'
              }
              xml.dataTable {
                xml.entityName 'Test dataset KBS'
                xml.physical {
                  xml.objectName 'test data'
                  xml.encodingMethod 'ASCII'
                  xml.dataFormat {
                    xml.textFormat {
                      xml.recordDelimiter '\n'
                      xml.attributeOrientation 'column'
                      xml.simpleDelimited {
                        xml.fieldDelimiter  ',' 
                      } 
                    }
                  }
                  xml.distribution {
                    xml.online {
                      xml.url 'http://gprpc28.kbs.msu.edu:9999/'
                    }
                  }
                }
                xml.attributeList {
                  xml.attribute {
                    xml.attributeName 'first column'
                    xml.attributeDefinition 'the first column'
                    xml.measurementScale {
                      xml.nominal {
                        xml.nonNumericDomain {
                          xml.textDomain {
                            xml.definition 'a number to test with'
                          }
                        }
                      }
                    }
                  }
               }
             }
          }
          xml.parent.namespace = xml.parent.namespace_definitions.find{|ns|ns.prefix=="eml"}
        }
  end
  doc = Nokogiri::XML(eml.to_xml)
  doc.root
end

def validate(eml)
  response = RestClient.post 'http://knb.ecoinformatics.org/emlparser/parse', :action=>'textparse', :doctext=>eml.to_xml
  response =~ /EML specific tests: Passed./ && response =~ /XML specific tests: Passed/
end
