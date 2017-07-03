require 'minitest/autorun'
require 'microsoft_rsa'

class TestMicrosoftRSA < Minitest::Test
  KEY_FILE = "./test/fixtures/2048.xml"

  def setup
    @rsa = MicrosoftRSA.load(KEY_FILE)
  end

  def test_microsoft_rsa_class
    assert_instance_of MicrosoftRSA, @rsa
  end

  def test_inspect_does_not_reveal_secrets
    assert_equal @rsa.to_s, @rsa.inspect
  end
end
