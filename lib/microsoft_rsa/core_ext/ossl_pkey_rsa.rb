require 'openssl'
require 'rexml/document'
require 'microsoft_rsa/utils'

class OpenSSL::PKey::RSA
  def to_xml
    rexml = self.to_rexml

    # Funky hack to write to a string instead of IO
    xml = ""
    rexml.write(xml, 2)
    xml
  end

  def to_rexml
    doc = REXML::Document.new
    doc.add_element('RSAKeyValue')

    MicrosoftRSA::ELEMENTS.each do |k,v|
      next if self.send(v).nil?
      text = MicrosoftRSA::Utils.bn_to_base64(self.send(v))
      doc[0] << REXML::Element.new(k).add_text(text)
    end

    doc
  end

  class << self
    def from_xml(source)
      unless source =~ /RSAKeyValue/
        source = ::File.new(source)
      end

      parse_xml(source)
    end

    def parse_xml(doc)
      rsa = OpenSSL::PKey::RSA.new

      doc = REXML::Document.new(doc)
      elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
      elements.each do |element|
        name = element.name
        value = element.text

        next unless MicrosoftRSA::ELEMENTS.include?(name)

        rsa.send("#{MicrosoftRSA::ELEMENTS[name]}=", MicrosoftRSA::Utils.base64_to_bn(value))
      end

      rsa
    end
  end
end
