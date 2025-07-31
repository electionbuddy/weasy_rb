# frozen_string_literal: true

module WeasyRb
  # Main converter class responsible for orchestrating HTML to PDF conversion
  # Follows Single Responsibility Principle by focusing only on conversion logic
  class Converter
    def initialize(command_builder: CommandBuilder.new, executor: Executor.new)
      @command_builder = command_builder
      @executor = executor
    end

    # Converts HTML content to PDF file
    # @param html [String] HTML content to convert
    # @param output_path [String] Path where the PDF will be saved
    # @param options [Hash] Additional options for WeasyPrint
    # @return [String] Path to the generated PDF file
    def convert(html, output_path, options = {})
      validate_inputs(html, output_path)

      command = @command_builder.build(output_path, options)
      result = @executor.execute(command, html)

      handle_result(result, output_path)
    end

    private

    def validate_inputs(html, output_path)
      raise ArgumentError, "HTML content cannot be empty" if html.nil? || html.strip.empty?
      raise ArgumentError, "Output path cannot be empty" if output_path.nil? || output_path.strip.empty?
    end

    def handle_result(result, output_path)
      raise ConversionError, "WeasyPrint conversion failed: #{result.error}" unless result.success?

      raise ConversionError, "PDF file was not created at #{output_path}" unless File.exist?(output_path)

      output_path
    end
  end
end
