# frozen_string_literal: true

module WeasyRb
  # Responsible for building WeasyPrint command strings
  # Follows Single Responsibility Principle and Open/Closed Principle
  class CommandBuilder
    WEASY_PRINT_COMMAND = "weasyprint"

    # Build WeasyPrint command with options
    # @param output_path [String] Path where the PDF will be saved
    # @param options [Hash] Additional options for WeasyPrint
    # @return [Array<String>] Command array ready for execution
    def build(output_path, options = {})
      command = [WEASY_PRINT_COMMAND]
      command.concat(build_options(options))
      command << "-" # Read from stdin
      command << output_path
      command
    end

    private

    def build_options(options)
      option_flags = []

      add_simple_option(option_flags, options, :base_url, "--base-url")
      add_simple_option(option_flags, options, :media_type, "--media-type")
      add_simple_option(option_flags, options, :format, "--format")
      add_simple_option(option_flags, options, :encoding, "--encoding")
      add_stylesheets_option(option_flags, options)
      add_verbose_option(option_flags, options)

      option_flags
    end

    def add_simple_option(option_flags, options, key, flag)
      option_flags.concat([flag, options[key]]) if options[key]
    end

    def add_stylesheets_option(option_flags, options)
      return unless options[:stylesheets]

      Array(options[:stylesheets]).each do |stylesheet|
        option_flags.concat(["--stylesheet", stylesheet])
      end
    end

    def add_verbose_option(option_flags, options)
      option_flags << "--verbose" if options[:verbose]
    end
  end
end
