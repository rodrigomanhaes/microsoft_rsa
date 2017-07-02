require 'rexml/document'

class MicrosoftRSA

  ELEMENTS = %w[Modulus Exponent D P Q DP DQ InverseQ]

  ELEMENTS.each do |x|
    attr_accessor x.downcase
  end

  def self.load(file)
    ms_rsa = self.new

    f = File.new(file)
    doc = REXML::Document.new(f)

    elements = REXML::XPath.match(doc, '/RSAKeyValue/*')
    elements.each do |e|
      next unless ELEMENTS.include?(e.name)
      ms_rsa.instance_variable_set("@#{e.name.downcase}", e.text)
    end

    ms_rsa
  end

  def inspect
    # Don't expose sensitive information to console
    self.to_s
  end
end
