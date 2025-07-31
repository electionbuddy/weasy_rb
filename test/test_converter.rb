# frozen_string_literal: true

require "test_helper"

class TestConverter < Minitest::Test
  def setup
    @mock_command_builder = Minitest::Mock.new
    @mock_executor = Minitest::Mock.new
    @converter = WeasyRb::Converter.new(
      command_builder: @mock_command_builder,
      executor: @mock_executor
    )
  end

  def test_convert_success
    html = "<html><body><h1>Test</h1></body></html>"
    output_path = "/tmp/test.pdf"
    options = { format: "A4" }

    command = ["weasyprint", "--format", "A4", "-", output_path]
    result = WeasyRb::Executor::Result.new(success: true)

    setup_mocks_for_success(command, result, output_path, options, html)

    File.stub(:exist?, true) do
      converted_path = @converter.convert(html, output_path, options)
      assert_equal output_path, converted_path
    end

    verify_mocks
  end

  def test_convert_with_empty_html
    assert_raises(ArgumentError, "HTML content cannot be empty") do
      @converter.convert("", "/tmp/test.pdf")
    end
  end

  def test_convert_with_nil_html
    assert_raises(ArgumentError, "HTML content cannot be empty") do
      @converter.convert(nil, "/tmp/test.pdf")
    end
  end

  def test_convert_with_empty_output_path
    html = "<html><body><h1>Test</h1></body></html>"

    assert_raises(ArgumentError, "Output path cannot be empty") do
      @converter.convert(html, "")
    end
  end

  def test_convert_with_execution_failure
    html = "<html><body><h1>Test</h1></body></html>"
    output_path = "/tmp/test.pdf"

    command = ["weasyprint", "-", output_path]
    result = WeasyRb::Executor::Result.new(success: false, error: "Command failed")

    @mock_command_builder.expect(:build, command, [output_path, {}])
    @mock_executor.expect(:execute, result, [command, html])

    assert_raises(WeasyRb::ConversionError, "WeasyPrint conversion failed: Command failed") do
      @converter.convert(html, output_path)
    end

    @mock_command_builder.verify
    @mock_executor.verify
  end

  def test_convert_with_missing_output_file
    html = "<html><body><h1>Test</h1></body></html>"
    output_path = "/tmp/test.pdf"

    command = ["weasyprint", "-", output_path]
    result = WeasyRb::Executor::Result.new(success: true)

    @mock_command_builder.expect(:build, command, [output_path, {}])
    @mock_executor.expect(:execute, result, [command, html])

    File.stub(:exist?, false) do
      assert_raises(WeasyRb::ConversionError, "PDF file was not created at #{output_path}") do
        @converter.convert(html, output_path)
      end
    end

    @mock_command_builder.verify
    @mock_executor.verify
  end

  private

  def setup_mocks_for_success(command, result, output_path, options, html)
    @mock_command_builder.expect(:build, command, [output_path, options])
    @mock_executor.expect(:execute, result, [command, html])
  end

  def verify_mocks
    @mock_command_builder.verify
    @mock_executor.verify
  end
end
