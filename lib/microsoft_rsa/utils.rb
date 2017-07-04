require 'base64'

class MicrosoftRSA
  # this Utils class contains helpful methods for MicrosoftRSA
  class Utils
    def self.base64_to_asn1_int(base64_string)
      OpenSSL::ASN1::Integer(base64_to_bn(base64_string))
    end

    private

    def self.base64_to_bn(base64_string)
      OpenSSL::BN.new(Base64.decode64(base64_string), 2)
    end
  end
end
