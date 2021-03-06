# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: microsoft_rsa 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "microsoft_rsa"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jason Barnett"]
  s.date = "2017-07-10"
  s.description = "This gem enables you to convert RSAKeyValue XML structures to OpenSSL RSA Private Key and vice versa"
  s.email = "jason.w.barnett@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".coveralls.yml",
    ".document",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/microsoft_rsa.rb",
    "lib/microsoft_rsa/core_ext/ossl_pkey_rsa.rb",
    "lib/microsoft_rsa/utils.rb",
    "microsoft_rsa.gemspec",
    "test/fixtures/2048.key",
    "test/fixtures/2048.xml",
    "test/microsoft_rsa/core_ext/ossl_pkey_rsa_test.rb",
    "test/microsoft_rsa/utils_test.rb",
    "test/microsoft_rsa_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = "http://github.com/jasonwbarnett/microsoft_rsa"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Microsoft RSAKeyValue XML structure support for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 12.0"])
      s.add_development_dependency(%q<guard>, ["~> 2.14"])
      s.add_development_dependency(%q<guard-minitest>, ["~> 2.4"])
    else
      s.add_dependency(%q<rake>, ["~> 12.0"])
      s.add_dependency(%q<guard>, ["~> 2.14"])
      s.add_dependency(%q<guard-minitest>, ["~> 2.4"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 12.0"])
    s.add_dependency(%q<guard>, ["~> 2.14"])
    s.add_dependency(%q<guard-minitest>, ["~> 2.4"])
  end
end

