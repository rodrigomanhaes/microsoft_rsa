require 'microsoft_rsa/core_ext/ossl_pkey_rsa'
require 'microsoft_rsa/utils'

module MicrosoftRSA
  ELEMENTS = {
    "Modulus"  => "n",
    "Exponent" => "e",
    "P"        => "p",
    "Q"        => "q",
    "DP"       => "dmp1",
    "DQ"       => "dmq1",
    "InverseQ" => "iqmp",
    "D"        => "d",
  }
end
