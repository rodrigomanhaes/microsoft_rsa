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
        ms_rsa.send("#{ELEMENTS[name]}=", element.text)
      end

      ms_rsa
    end
  end

  def to_openssl_pkey
    asn1_sequence = OpenSSL::ASN1::Sequence([
      OpenSSL::ASN1::Integer(0),
      Utils.base64_to_asn1_int(n),
      Utils.base64_to_asn1_int(e),
      Utils.base64_to_asn1_int(d),
      Utils.base64_to_asn1_int(p),
      Utils.base64_to_asn1_int(q),
      Utils.base64_to_asn1_int(dmp1),
      Utils.base64_to_asn1_int(dmq1),
      Utils.base64_to_asn1_int(iqmp),
    ])
    OpenSSL::PKey::RSA.new(asn1_sequence.to_der)
  end

  alias :inspect_old :inspect

  def inspect
    # Don't expose sensitive information to console
    self.to_s
  end

  def save
    #::File.
  end

  def build
    ERB.new(microsoft_rsa_template, safe_level=nil, trim_mode='-').result(binding)
  end

  def microsoft_rsa_template
    %q{
      <RSAKeyValue>
        <%= self.inspect %>
        <% MicrosoftRSA::ELEMENTS.each do |k,v| -%>
        <% "<#{k}>#{self.send(v)}</#{k}>" unless self.send(v).nil? %>
        <% end -%>
      </RSAKeyValue>
    }.strip_heredoc
  end
end
