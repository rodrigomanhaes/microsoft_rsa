require 'rexml/document'

class MicrosoftRSA

  ELEMENTS = %w[Modulus Exponent D P Q DP DQ InverseQ]

  ELEMENTS.each do |x|
    attr_accessor x.downcase
  end

  def self.load(xml)
    file = File.new("mydoc.xml")
    doc = REXML::Document.new file
    elements = doc.elements.to_a("/*/*")
    elements.select! { |x| ELEMENTS.include?(x.name) }
    elements.each do |e|
      e.name
      e.text
    end
  end
end
