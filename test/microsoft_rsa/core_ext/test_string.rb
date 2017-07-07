require 'minitest/autorun'
require 'microsoft_rsa'

class TestString < Minitest::Test
  def test_strip_heredoc_on_an_empty_string
    assert_equal "", "".strip_heredoc
  end

  def test_strip_heredoc_on_a_string_with_no_lines
    assert_equal "x", "x".strip_heredoc
    assert_equal "x", "    x".strip_heredoc
  end

  def test_strip_heredoc_on_a_heredoc_with_no_margin
    assert_equal "foo\nbar", "foo\nbar".strip_heredoc
    assert_equal "foo\n  bar", "foo\n  bar".strip_heredoc
  end

  def test_strip_heredoc_on_a_regular_indented_heredoc
    assert_equal "foo\n  bar\nbaz\n", <<-EOS.strip_heredoc
      foo
        bar
      baz
    EOS
  end

  def test_strip_heredoc_on_a_regular_indented_heredoc_with_blank_lines
    assert_equal "foo\n  bar\n\nbaz\n", <<-EOS.strip_heredoc
      foo
        bar

      baz
    EOS
  end
end
