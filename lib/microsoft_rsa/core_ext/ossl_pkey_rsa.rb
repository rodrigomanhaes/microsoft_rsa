require 'rexml/document'
require 'erb'

require 'microsoft_rsa'

class OpenSSL::PKey::RSA
  def to_microsoft_rsa
    ms_rsa = MicrosoftRSA.new

    MicrosoftRSA::ELEMENTS.each_value do |v|
      if bn = self.send(v)
        ms_rsa.send("#{v}=", MicrosoftRSA::Utils.bn_to_base64(bn))
      end
    end

    ms_rsa
  end
end
