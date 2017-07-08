require 'minitest/autorun'
require 'microsoft_rsa'

class TestMicrosoftRSAModule < Minitest::Test
  def test_microsoft_rsa_is_a_module
    assert_instance_of Module, MicrosoftRSA
  end

  def test_elements
    assert_equal ({"Modulus"=>"n", "Exponent"=>"e", "P"=>"p", "Q"=>"q", "DP"=>"dmp1", "DQ"=>"dmq1", "InverseQ"=>"iqmp", "D"=>"d"}), MicrosoftRSA::ELEMENTS
  end
end
