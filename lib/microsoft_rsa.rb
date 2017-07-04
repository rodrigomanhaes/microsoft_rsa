require 'rexml/document'
require 'base64'
require 'openssl'

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

  ELEMENTS.each_value do |v|
    attr_reader v
  end

  def self.load(file)
    ms_rsa = self.new

    f = File.new(file)
    doc = REXML::Document.new(f)

    elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
    elements.each do |e|
      next unless ELEMENTS.include?(e.name)
      ms_rsa.instance_variable_set("@#{ELEMENTS[e.name]}", e.text)
    end

    ms_rsa
  end

  def to_openssl_pkey
    asn1 = OpenSSL::ASN1::Sequence([
      OpenSSL::ASN1::Integer(0),
      base64_to_asn1_int(@n),
      base64_to_asn1_int(@e),
      base64_to_asn1_int(@d),
      base64_to_asn1_int(@p),
      base64_to_asn1_int(@q),
      base64_to_asn1_int(@dmp1),
      base64_to_asn1_int(@dmq1),
      base64_to_asn1_int(@iqmp),
    ])
    OpenSSL::PKey::RSA.new(asn1.to_der)
  end

  def inspect
    # Don't expose sensitive information to console
    self.to_s
  end

  private

  def base64_to_asn1_int(s)
    bn = OpenSSL::BN.new(Base64.decode64(s), 2)
    OpenSSL::ASN1::Integer(bn)
  end
end
