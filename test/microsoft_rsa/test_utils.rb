require 'minitest/autorun'
require 'microsoft_rsa/utils'

module MicrosoftRSA
  class TestUtils < Minitest::Test
    def setup
      @openssl_bn = OpenSSL::BN.new(163522340394490646945635106841219113001963426242092881020812618701555971082490743248947493757237551480789691000295819582772828774582811486739272453435329620448921747293869647887802309676311317354511548539775295656018590596834363075281484562434093198008676541407535217799639831961860192999217197690686157047523)
      @base64 = "6N0RHDqBuIQ0k6545YSgsin0XZ3WmTIxEsZPDOGJ2+W9sQ6uD7PMMOqx65lmboqn42hOwfHjfFozW/Ay1ymWfXlIA5vW/rUP4jPKC3j/7vDgRjyDFCGCQqsuvGFTdW8JtVaUPGl4gVsu2+UIyY5qPWqnzW5TEd9rjRcbJrnvRuM="
    end

    def test_base64_to_bn
      assert_instance_of OpenSSL::BN, Utils.base64_to_bn(@base64)
      assert_equal @openssl_bn, Utils.base64_to_bn(@base64)
    end

    def test_bn_to_base64
      assert_instance_of String, Utils.bn_to_base64(@openssl_bn)
      assert_equal @base64, Utils.bn_to_base64(@openssl_bn)
    end
  end
end
