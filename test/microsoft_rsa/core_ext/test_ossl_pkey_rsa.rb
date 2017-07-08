require 'minitest/autorun'
require 'microsoft_rsa'

class TestOpenSSLPKeyRSA < Minitest::Test
  XML_PRIVATE_KEY = "./test/fixtures/2048.xml"
  RSA_PRIVATE_KEY = "./test/fixtures/2048.key"

  def setup
    @rsa_key = OpenSSL::PKey::RSA.new(::File.read(RSA_PRIVATE_KEY))
  end

  def test_from_xml
    assert_equal @rsa_key.params, OpenSSL::PKey::RSA.from_xml(XML_PRIVATE_KEY).params
  end

  def test_to_xml
    assert_equal ::File.read(XML_PRIVATE_KEY).strip, @rsa_key.to_xml.strip
  end
end
