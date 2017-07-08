require 'rexml/document'
require 'erb'

require 'microsoft_rsa'

class OpenSSL::PKey::RSA
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
