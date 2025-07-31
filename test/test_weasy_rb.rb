# frozen_string_literal: true

require "test_helper"
require "tempfile"

class TestWeasyRb < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WeasyRb::VERSION
  end

  def test_html_to_pdf_with_valid_input
    html = "<html><body><h1>Test</h1></body></html>"

    Tempfile.create(["test", ".pdf"]) do |file|
      output_path = file.path

      # Mock the executor to avoid needing actual WeasyPrint installation
      mock_executor = create_mock_executor
      mock_result = WeasyRb::Executor::Result.new(success: true, output: "", error: "")
      mock_executor.expect(:execute, mock_result, [Array, String])

      # Mock file existence check
      File.stub(:exist?, true) do
        converter = WeasyRb::Converter.new(executor: mock_executor)
        result = converter.convert(html, output_path)

        assert_equal output_path, result
      end

      mock_executor.verify
    end
  end

  private

  def create_mock_executor
    Minitest::Mock.new
  end

  def test_html_to_pdf_with_empty_html
    assert_raises(ArgumentError) do
      WeasyRb.html_to_pdf("", "/tmp/test.pdf")
    end
  end

  def test_html_to_pdf_with_nil_html
    assert_raises(ArgumentError) do
      WeasyRb.html_to_pdf(nil, "/tmp/test.pdf")
    end
  end

  def test_html_to_pdf_with_empty_output_path
    html = "<html><body><h1>Test</h1></body></html>"

    assert_raises(ArgumentError) do
      WeasyRb.html_to_pdf(html, "")
    end
  end
end
