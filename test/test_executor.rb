# frozen_string_literal: true

require "test_helper"

class TestExecutor < Minitest::Test
  def setup
    @executor = WeasyRb::Executor.new
  end

  def test_result_initialization
    result = WeasyRb::Executor::Result.new(
      success: true,
      output: "test output",
      error: "test error",
      exit_status: 0
    )

    assert result.success?
    assert_equal "test output", result.output
    assert_equal "test error", result.error
    assert_equal 0, result.exit_status
  end

  def test_result_default_values
    result = WeasyRb::Executor::Result.new(success: false)

    refute result.success?
    assert_equal "", result.output
    assert_equal "", result.error
    assert_nil result.exit_status
  end

  def test_execute_command_not_found
    # Mock Open3.capture3 to raise Errno::ENOENT
    Open3.stub(:capture3, ->(*_args) { raise Errno::ENOENT }) do
      assert_raises(WeasyRb::CommandError, "WeasyPrint is not installed or not available in PATH") do
        @executor.execute(["nonexistent-command"], "<html></html>")
      end
    end
  end

  def test_execute_general_error
    # Mock Open3.capture3 to raise a general error
    Open3.stub(:capture3, ->(*_args) { raise StandardError, "Something went wrong" }) do
      assert_raises(WeasyRb::CommandError, "Failed to execute WeasyPrint: Something went wrong") do
        @executor.execute(["weasyprint"], "<html></html>")
      end
    end
  end

  def test_validate_weasyprint_availability_success
    # Mock successful which command
    success_status = Minitest::Mock.new
    success_status.expect(:success?, true)

    Open3.stub(:capture3, ["", "", success_status]) do
      # This should not raise an error
      @executor.send(:validate_weasyprint_availability)
    end

    success_status.verify
  end

  def test_validate_weasyprint_availability_failure
    # Mock failed which command
    failed_status = Minitest::Mock.new
    failed_status.expect(:success?, false)

    Open3.stub(:capture3, ["", "", failed_status]) do
      assert_raises(WeasyRb::CommandError, "WeasyPrint is not installed or not available in PATH") do
        @executor.send(:validate_weasyprint_availability)
      end
    end

    failed_status.verify
  end
end
