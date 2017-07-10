require 'test_helper'

class OpenSSLPKeyRSATest < Minitest::Test
  XML_PRIVATE_KEY = "./test/fixtures/2048.xml"
  RSA_PRIVATE_KEY = "./test/fixtures/2048.key"

  def setup
    @rsa_key = OpenSSL::PKey::RSA.new(::File.read(RSA_PRIVATE_KEY))
  end

  def test_from_xml
    assert_equal @rsa_key.params, OpenSSL::PKey::RSA.from_xml(XML_PRIVATE_KEY).params
  end

  def test_to_xml
    assert_instance_of String, @rsa_key.to_xml
    assert_equal ::File.read(XML_PRIVATE_KEY).strip, @rsa_key.to_xml.strip
  end

  def test_to_rexml
    rexml = @rsa_key.to_rexml
    assert_instance_of REXML::Document, @rsa_key.to_rexml

    MicrosoftRSA::ELEMENTS.each do |k,v|
      element = REXML::XPath.first(rexml, "/RSAKeyValue/#{k}")
      assert_instance_of REXML::Element, element
    end
  end
end
