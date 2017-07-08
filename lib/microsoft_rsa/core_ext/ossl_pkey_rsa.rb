require 'openssl'
require 'rexml/document'

require 'microsoft_rsa'

class OpenSSL::PKey::RSA
  def to_xml
    doc = REXML::Document.new
    doc.add_element('RSAKeyValue')

    MicrosoftRSA::ELEMENTS.each do |k,v|
      next if self.send(v).nil?
      text = MicrosoftRSA::Utils.bn_to_base64(self.send(v))
      doc[0] << REXML::Element.new(k).add_text(text)
    end

    # Funky hack to write to a string instead of IO
    xml = ""
    doc.write(xml, 2)
    xml
  end

  class << self
    def from_xml(source)
      unless source =~ /RSAKeyValue/
        source = ::File.new(source)
      end

      parse_xml(source)
    end

    def parse_xml(doc)
      rsa = new

      doc = REXML::Document.new(doc)
      elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
      elements.each do |element|
        name = element.name
        value = element.text

        next unless MicrosoftRSA::ELEMENTS.include?(name)

        rsa.send("#{MicrosoftRSA::ELEMENTS[name]}=", MicrosoftRSA::Utils.base64_to_bn(element.text))
      end

      rsa
    end
  end
end
