## Uncomment to clear the screen before every task
clearing :off

guard :minitest, include: ['lib'] do
  # with Minitest::Unit
  watch(%r{^test/test_helper\.rb$})      { 'test' }
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}#{m[2]}_test.rb" }
end
