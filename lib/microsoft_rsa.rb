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
    
    elements = doc.elements.to_a("/RSAKeyValue/*")
    elements.select! { |x| ELEMENTS.include?(x.name) }
    elements.each do |e|
      ms_rsa.instance_variable_set(x.downcase, e.text)
    end
    
    ms_rsa
  end
end
