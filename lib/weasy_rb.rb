# frozen_string_literal: true

require_relative "weasy_rb/version"
require_relative "weasy_rb/converter"
require_relative "weasy_rb/command_builder"
require_relative "weasy_rb/executor"

# WeasyRb is a Ruby wrapper for the WeasyPrint Python library.
# It provides a simple interface to convert HTML documents to PDF files.
#
# @example Basic usage
#   html = "<html><body><h1>Hello, PDF!</h1></body></html>"
#   WeasyRb.html_to_pdf(html, "/tmp/output.pdf")
#
# @example With options
#   options = { format: "A4", media_type: "print" }
#   WeasyRb.html_to_pdf(html, "/tmp/output.pdf", options)
module WeasyRb
  class Error < StandardError; end
  class CommandError < Error; end
  class ConversionError < Error; end

  # Main entry point for HTML to PDF conversion
  # @param html [String] HTML content to convert
  # @param output_path [String] Path where the PDF will be saved
  # @param options [Hash] Additional options for WeasyPrint
  # @return [String] Path to the generated PDF file
  def self.html_to_pdf(html, output_path, options = {})
    Converter.new.convert(html, output_path, options)
  end
end
