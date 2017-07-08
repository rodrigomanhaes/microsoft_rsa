require 'minitest/autorun'
require 'microsoft_rsa'

class TestOpenSSLPKeyRSA < Minitest::Test
  XML_PRIVATE_KEY = "./test/fixtures/2048.xml"
  RSA_PRIVATE_KEY = "./test/fixtures/2048.key"

  def test_loading_from_xml
    assert_equal OpenSSL::PKey::RSA.new(::File.read(RSA_PRIVATE_KEY)).params, OpenSSL::PKey::RSA.from_xml(XML_PRIVATE_KEY).params
  end
end
