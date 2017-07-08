require 'rexml/document'
require 'openssl'

require 'microsoft_rsa/utils'
require 'microsoft_rsa/core_ext/ossl_pkey_rsa'
require 'microsoft_rsa/core_ext/string'

# the MicrosoftRSA class represents Microsoft's RSAKeyValue XML structure
# for a RSA Private Key
class MicrosoftRSA

  ELEMENTS = {
    "Modulus"  => "n",
    "Exponent" => "e",
    "P"        => "p",
    "Q"        => "q",
    "DP"       => "dmp1",
    "DQ"       => "dmq1",
    "InverseQ" => "iqmp",
    "D"        => "d",
  }

  ELEMENTS.each_value do |field|
    attr_accessor field
  end

  class << self
    def load(source)
      unless source =~ /RSAKeyValue/
        source = ::File.new(source)
      end

      parse(source)
    end

    def parse(doc)
      ms_rsa = new
      doc = REXML::Document.new(doc)

      elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
      elements.each do |element|
        name = element.name
        value = element.text

        next unless ELEMENTS.include?(name)
        ms_rsa.send("#{ELEMENTS[name]}=", element.text.strip)
      end

      ms_rsa
    end
  end

  def to_openssl_pkey
    pkey = OpenSSL::PKey::RSA.new
    ELEMENTS.each_value do |method|
      pkey.send("#{method}=", Utils.base64_to_bn(self.send(method))) unless self.send(method).nil?
    end
    pkey
  end

  alias :inspect_old :inspect

  def inspect
    # Don't expose sensitive information to console
    self.to_s
  end

  def save(filename)
    ::File.open(filename, 'w') {|f| build_xml_doc.write(f, 2) }
  end

  def build_xml_doc
    doc = REXML::Document.new
    doc.add_element('RSAKeyValue')

    MicrosoftRSA::ELEMENTS.each do |k,v|
      doc[0] << REXML::Element.new(k).add_text(self.send(v)) unless self.send(v).nil?
    end

    doc
  end

  def build_xml_string
    template = File.join(File.dirname(__FILE__), "/templates/RSAKeyValue.xml.erb")
    ERB.new(::File.read(template), safe_level=nil, trim_mode='-').result(binding)
  end

  def microsoft_rsa_template
    %q{RSAKeyValue>\n<% MicrosoftRSA::ELEMENTS.each do |k,v| -%>\n  <%= "<#{k}>#{self.send(v)}</#{k}>" unless self.send(v).nil? %>\n<% end -%>\n</RSAKeyValue>\n}
  end
end
