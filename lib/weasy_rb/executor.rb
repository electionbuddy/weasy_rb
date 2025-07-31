# frozen_string_literal: true

require "open3"

module WeasyRb
  # Executes WeasyPrint commands using Open3
  class Executor
    # Result class to encapsulate command execution results
    Result = Struct.new(:success?, :output, :error, :exit_status) do
      def initialize(success:, output: "", error: "", exit_status: nil)
        super(success, output, error, exit_status)
      end
    end

    # Execute WeasyPrint command with HTML input
    # @param command [Array<String>] Command array to execute
    # @param html_content [String] HTML content to pipe to stdin
    # @return [Result] Execution result
    # rubocop:disable Metrics/MethodLength
    def execute(command, html_content)
      validate_weasyprint_availability

      stdout, stderr, status = capture_command_output(command, html_content)

      Result.new(
        success: status.success?,
        output: stdout,
        error: stderr,
        exit_status: status.exitstatus
      )
    rescue Errno::ENOENT
      raise CommandError, "WeasyPrint is not installed or not available in PATH"
    rescue StandardError => e
      raise CommandError, "Failed to execute WeasyPrint: #{e.message}"
    end
    # rubocop:enable Metrics/MethodLength

    private

    def capture_command_output(command, html_content)
      Open3.capture3(*command, stdin_data: html_content)
    end

    def validate_weasyprint_availability
      # Check if weasyprint is available in PATH
      _stdout, _stderr, status = Open3.capture3("which", "weasyprint")

      return if status.success?

      raise CommandError, "WeasyPrint is not installed or not available in PATH"
    end
  end
end
