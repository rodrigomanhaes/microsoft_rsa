require 'rexml/document'
require 'openssl'

require 'microsoft_rsa/utils'

# the MicrosoftRSA class represents Microsoft's RSAKeyValue XML structure
# for a RSA Private Key
class MicrosoftRSA

  ELEMENTS = {
    "Modulus"  => "n",
    "Exponent" => "e",
    "D"        => "d",
    "P"        => "p",
    "Q"        => "q",
    "DP"       => "dmp1",
    "DQ"       => "dmq1",
    "InverseQ" => "iqmp",
  }

  ELEMENTS.each_value do |field|
    attr_reader field
  end

  def self.load(source)
    unless source =~ /RSAKeyValue/
      source = ::File.new(source)
    end

    parse(source)
  end

  def self.parse(doc)
    ms_rsa = self.new
    doc = REXML::Document.new(doc)

    elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
    elements.each do |element|
      name = element.name
      next unless ELEMENTS.include?(name)
      ms_rsa.instance_variable_set("@#{ELEMENTS[name]}", element.text)
    end

    ms_rsa
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

    def inspect
      # Don't expose sensitive information to console
      self.to_s
    end
  end
