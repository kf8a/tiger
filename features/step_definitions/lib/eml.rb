require 'nokogiri'
require 'data_mapper'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/eml.db")

class EML
  include DataMapper::Resource
  property :id,   Serial
  property :rev,  Integer, :default => 1

  attr_accessor :identifier

  def next_rev
    self.rev = self.rev + 1
  end

  def identifier
    @identifier || 'knb-lter-tbs'
  end

  def doc
    eml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.eml("xmlns:eml" => "eml://ecoinformatics.org/eml-2.1.0", 
              "packageId" => "#{identifier}.#{id}.#{rev}",
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
                        xml.url 'http://gprpc32.kbs.msu.edu:9999/'
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

  def validate
    response = RestClient.post 'http://knb.ecoinformatics.org/emlparser/parse', :action=>'textparse', :doctext=>to_xml
    response =~ /EML specific tests: Passed./ && response =~ /XML specific tests: Passed/
  end

  def to_xml
    doc.to_xml
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!
