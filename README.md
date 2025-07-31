# WeasyRb

A dead simple Ruby wrapper for [WeasyPrint](https://github.com/Kozea/WeasyPrint), the Python library that converts HTML documents to PDF files. WeasyRb provides a clean and Ruby-idiomatic interface to WeasyPrint while handling the complexities of process execution and error handling.

## Features

- **Simple API**: Convert HTML to PDF with a single method call
- **Clean Architecture**: Follows SOLID principles and Clean Code practices
- **Error Handling**: Comprehensive error handling with meaningful error messages
- **Flexible Options**: Support for WeasyPrint's various configuration options
- **Process Safety**: Uses Open3 for safe subprocess execution

## Prerequisites

WeasyPrint must be installed on your system. You can install it via pip:

```bash
pip install weasyprint
```

For more installation options, see the [WeasyPrint documentation](https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#installation).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "weasy_rb"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install weasy_rb
```

## Usage

### Basic Usage

```ruby
require "weasy_rb"

html_content = "<html><body><h1>Hello, PDF!</h1></body></html>"
output_path = "/tmp/output.pdf"

# Convert HTML to PDF
WeasyRb.html_to_pdf(html_content, output_path)
```

### With Options

```ruby
require "weasy_rb"

html_content = File.read("document.html")
output_path = "output.pdf"

options = {
  base_url: "file:///path/to/assets/",
  format: "A4",
  media_type: "print",
  stylesheets: ["style.css"],
  encoding: "utf-8"
}

WeasyRb.html_to_pdf(html_content, output_path, options)
```

### Available Options

- `base_url`: Base URL for resolving relative URLs in the HTML
- `format`: Page format (A4, Letter, etc.)
- `media_type`: CSS media type ("print" or "screen")
- `stylesheets`: Array of stylesheet paths to include
- `encoding`: Character encoding for the HTML content
- `verbose`: Enable verbose output for debugging

### Docker Examples

Try the included examples to see WeasyRb in action:

```bash
# Run the basic example
docker-compose run --rm weasy_rb ruby examples/basic_example.rb

# Run the decorated demo (with subtle emoji support)
docker-compose run --rm weasy_rb ruby examples/decorated_demo.rb

# Interactive exploration
docker-compose run --rm console
```

## Error Handling

WeasyRb provides specific error classes for different failure scenarios:

```ruby
begin
  WeasyRb.html_to_pdf(html_content, output_path)
rescue WeasyRb::CommandError => e
  # WeasyPrint is not installed or command execution failed
  puts "Command error: #{e.message}"
rescue WeasyRb::ConversionError => e
  # PDF conversion failed
  puts "Conversion error: #{e.message}"
rescue ArgumentError => e
  # Invalid input parameters
  puts "Invalid input: #{e.message}"
end
```

## Development

### Local Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Docker Development (Recommended)

For the easiest development experience, use Docker which includes all dependencies:

```bash
# Build and run tests
make build-and-test

# Interactive development shell
make dev

# Ruby console with gem loaded
make console

# Run tests
make test

# Run linter
make lint
```

See [DOCKER.md](DOCKER.md) for detailed Docker development instructions.

### Publishing

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Rynaro/weasy_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
