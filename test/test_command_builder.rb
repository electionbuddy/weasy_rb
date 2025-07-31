# frozen_string_literal: true

require "test_helper"

class TestCommandBuilder < Minitest::Test
  def setup
    @builder = WeasyRb::CommandBuilder.new
  end

  def test_build_basic_command
    output_path = "/tmp/test.pdf"
    expected = ["weasyprint", "-", output_path]

    result = @builder.build(output_path)
    assert_equal expected, result
  end

  def test_build_with_base_url
    output_path = "/tmp/test.pdf"
    options = { base_url: "file:///path/to/assets/" }
    expected = ["weasyprint", "--base-url", "file:///path/to/assets/", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_media_type
    output_path = "/tmp/test.pdf"
    options = { media_type: "print" }
    expected = ["weasyprint", "--media-type", "print", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_format
    output_path = "/tmp/test.pdf"
    options = { format: "A4" }
    expected = ["weasyprint", "--format", "A4", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_encoding
    output_path = "/tmp/test.pdf"
    options = { encoding: "utf-8" }
    expected = ["weasyprint", "--encoding", "utf-8", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_single_stylesheet
    output_path = "/tmp/test.pdf"
    options = { stylesheets: "style.css" }
    expected = ["weasyprint", "--stylesheet", "style.css", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_multiple_stylesheets
    output_path = "/tmp/test.pdf"
    options = { stylesheets: ["style1.css", "style2.css"] }
    expected = [
      "weasyprint",
      "--stylesheet", "style1.css",
      "--stylesheet", "style2.css",
      "-", output_path
    ]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_verbose
    output_path = "/tmp/test.pdf"
    options = { verbose: true }
    expected = ["weasyprint", "--verbose", "-", output_path]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end

  def test_build_with_all_options
    output_path = "/tmp/test.pdf"
    options = {
      base_url: "file:///assets/",
      media_type: "print",
      format: "A4",
      encoding: "utf-8",
      stylesheets: ["style1.css", "style2.css"],
      verbose: true
    }

    expected = [
      "weasyprint",
      "--base-url", "file:///assets/",
      "--media-type", "print",
      "--format", "A4",
      "--encoding", "utf-8",
      "--stylesheet", "style1.css",
      "--stylesheet", "style2.css",
      "--verbose",
      "-", output_path
    ]

    result = @builder.build(output_path, options)
    assert_equal expected, result
  end
end
