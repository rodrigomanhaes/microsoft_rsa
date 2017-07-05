require 'minitest/autorun'
require 'microsoft_rsa'

class TestMicrosoftRSA < Minitest::Test
  XML_PRIVATE_KEY = "./test/fixtures/2048.xml"
  RSA_PRIVATE_KEY = "./test/fixtures/2048.key"

  def setup
    @ms_rsa = MicrosoftRSA.load(XML_PRIVATE_KEY)
  end

  def test_parse_rsa_string
    ms_rsa = MicrosoftRSA.parse(::File.read(XML_PRIVATE_KEY))
    assert_instance_of OpenSSL::PKey::RSA, ms_rsa.to_openssl_pkey
  end

  def test_parse_rsa_file
    ms_rsa = MicrosoftRSA.parse(::File.new(XML_PRIVATE_KEY))
    assert_instance_of OpenSSL::PKey::RSA, ms_rsa.to_openssl_pkey
  end

  def test_microsoft_rsa_class
    assert_instance_of MicrosoftRSA, @ms_rsa
  end

  def test_inspect_does_not_reveal_secrets
    assert_equal @ms_rsa.to_s, @ms_rsa.inspect
  end

  def test_to_openssl_pkey
    openssl_pkey = ::File.read(RSA_PRIVATE_KEY)
    assert_equal openssl_pkey, @ms_rsa.to_openssl_pkey.to_s
  end

  def test_rsa_modulus
    assert_equal "0yAAH8dxP70kF1V5GMfWtomAVWLnvF1pBLlTpvdAxO078BZvNVJTi7ck5Knkduw33fBUHlntDGM/yycYhwRmKye75w95nH+fysoNNJshTOepNZvdjzOX1pJv5m1MFa/iCtypRe0HX/pSQRjDLdiwRw8dsXiAjHNF90nYxJNI32b1byDiMfgMIBrrcfCJmn1NinZYGjkN6/uaKRAm5eTY9EX1S4UQzcg0fBCGGeJT5NmxyzE2pNELLk49w+LL/tAhU61jK+/5BStQtC1JRxg3biudu4du6NGJ7HlglPNSLNR0REFla0Q8u4/UFjDftBhm5ybIzYk3j03Jg9X2Q8+HBw==", @ms_rsa.n
  end

  def test_rsa_public_exponent
    assert_equal "AQAB", @ms_rsa.e
  end

  def test_rsa_private_exponent
    assert_equal "d68MYveNG7T9YLzziTjAX3pTZhRLilzpy+PDqENCVGCoOdJ9+JxTAEEyiO5GtaPzh71V8l7IIt2grGndXa0AvjYoLzR2nGE9FJi2I7xNhGtPYTSaxTNaQCmDhf0vxJuQaNfundVg+OfO+VgwTS0pwR6wlorZVMWEREt4tvdHuFx98BCnfJKkAyARvjSxd+LWl6wjrkdrn+qIps83IoCljzohcTecu9EZG2k76Kr4arfiw8sHdGg2ECIEj9N7F6r/JvPcTkzlfqV50m7m5OPnLpMdyr0FLx9m/wDQkVbhfN7u9objuymaPjKteM49vxnnAYXj8Tiv5lT4fml7IE2LAQ==", @ms_rsa.d
  end

  def test_rsa_prime1
    assert_equal "6N0RHDqBuIQ0k6545YSgsin0XZ3WmTIxEsZPDOGJ2+W9sQ6uD7PMMOqx65lmboqn42hOwfHjfFozW/Ay1ymWfXlIA5vW/rUP4jPKC3j/7vDgRjyDFCGCQqsuvGFTdW8JtVaUPGl4gVsu2+UIyY5qPWqnzW5TEd9rjRcbJrnvRuM=", @ms_rsa.p
  end

  def test_rsa_prime2
    assert_equal "6BoCYYxXAvoGZFgKKkhvzQb3UPXNqSdyfZB0KVR0EeUUnCOHv7Mi5e9JRl5CVoomsDUlaQQvMdSZv05XBRKz3C1ksHipRMMh4MaqurEikD62MuhzmOAxzKsT2ahwGslBSwStpAgZM0ZFU57GP/M+U6Ic0muVLL/yVzEuZaGhVI0=", @ms_rsa.q
  end

  def test_rsa_exponent1
    assert_equal "WF7kymitp/+MEGuK99dAQLzJPunScerpUq2tfD7vWWMzfMkMZ2sdV4cJpFZf2B2InzWLhfCtGxkEGqTqNltTACURnkT670h5UafDylzOC7if9CesuuwIihJ6twTcblmIPqgvs0l3cOfQvaSKlCsWyF38dmqi3cqC/1VAeY7gbm8=", @ms_rsa.dmp1
  end

  def test_rsa_exponent2
    assert_equal "H1w8TB/hNdbAfFhk7zegW4yAaCD+K8fXsV2ORHNTx4MzWLF4Sw+SPI0rUmW0AuthtNdJeboGAm6eY3nbSiUvxiUgALQc8tyGvE87jEQYznKavaAo1lQchnHrGbKniwb8Wn2EVLB/by0ketruIH/mQPibelbs7gH1ZZCQm0zOdpU=", @ms_rsa.dmq1
  end

  def test_rsa_coefficient
    assert_equal "wE5D0CvtosSpEw3nUKxM2ZRTQfzcVrkLlwrJ9NggJFzAoedhM9r4nNyYESPsMhB+pWodGjuatLR1swZ7Ffa0DV52C4u2W2/ENwksi2U6Lud9/t4MYNb9Mg2Empv5m1lRneR7YalbHRaX54i2V5mxyDknQr0z8df2Umca63ODqYM=", @ms_rsa.iqmp
  end
end
