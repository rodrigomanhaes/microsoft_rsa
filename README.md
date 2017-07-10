[![Coverage Status](https://coveralls.io/repos/github/jasonwbarnett/microsoft_rsa/badge.svg?branch=master)](https://coveralls.io/github/jasonwbarnett/microsoft_rsa?branch=master)
[![Build Status](https://travis-ci.org/jasonwbarnett/microsoft_rsa.svg?branch=master)](https://travis-ci.org/jasonwbarnett/microsoft_rsa)

microsoft_rsa
=============

Add support for Microsoft's `RSAKeyValue` XML keys to Ruby's `OpenSSL::PKey::RSA` class.

Usage
-----

```ruby
require 'microsoft_rsa'

xml = <<-EOF
<RSAKeyValue>
   <Modulus>t6tLd1Wi7PEkwPfx9KGP1Ps/5F2saXnOsCE2U....</Modulus>
   <Exponent>AQAB</Exponent>
   <P>3LJ5y4Vla7cS3XgmbIH5dQgppUHa+aSWavEOCbDRS/M....</P>
   <Q>1QyGIAnjv4YLcRVdwXtxWkijc+aZ496qIBZnCAUUD/E....</Q>
   <DP>0821dc0f+LBKOqIEvj4+2kJrNV5ueQesFBYkEsjPFM....</DP>
   <DQ>ugSzX2oDJwjdGKG1OOiVcmUWAm6IU4PpOxcUYtY8TC....</DQ>
   <InverseQ>LDQIQu+LSB6CSZBrGxNQthWi9mkuPGVZyDDr....</InverseQ>
   <D>qZm2bXKH8WwbsJ8ZlT3S1TbgUifppLrqSRkb8XqEcMv....</D>
</RSAKeyValue>
EOF

rsa = OpenSSL::PKey::RSA.from_xml(xml)
# => #<OpenSSL::PKey::RSA:0x007fcd851527c8>

rsa.to_xml
# => "<RSAKeyValue>\n   <Modulus>t6tLd1Wi7PEkwPfx9KGP1Ps/5F2saXnOsCE2U....</Modulus>\n   <Exponent>AQAB</Exponent>\n   <P>3LJ5y4Vla7cS3XgmbIH5dQgppUHa+aSWavEOCbDRS/M....</P>\n   <Q>1QyGIAnjv4YLcRVdwXtxWkijc+aZ496qIBZnCAUUD/E....</Q>\n   <DP>0821dc0f+LBKOqIEvj4+2kJrNV5ueQesFBYkEsjPFM....</DP>\n   <DQ>ugSzX2oDJwjdGKG1OOiVcmUWAm6IU4PpOxcUYtY8TC....</DQ>\n   <InverseQ>LDQIQu+LSB6CSZBrGxNQthWi9mkuPGVZyDDr....</InverseQ>\n   <D>qZm2bXKH8WwbsJ8ZlT3S1TbgUifppLrqSRkb8XqEcMv....</D>\n</RSAKeyValue>\n"

rsa.to_rexml.class.name
# => "REXML::Document"
```

Contributing to microsoft_rsa
-----------------------------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2017 Jason Barnett. See LICENSE.txt for
further details.
