# frozen_string_literal: true

require_relative "lib/weasy_rb/version"

Gem::Specification.new do |spec|
  spec.name = "weasy_rb"
  spec.version = WeasyRb::VERSION
  spec.authors = ["Henrique Aparecido Lavezzo"]
  spec.email = ["henriquel@electionbuddy.com"]

  spec.summary = "A simple Ruby wrapper for WeasyPrint HTML to PDF converter"
  spec.description = "WeasyRb provides a clean and simple Ruby interface to the " \
                     "WeasyPrint Python library for converting HTML documents to PDF files."
  spec.homepage = "https://github.com/electionbuddy/weasy_rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
