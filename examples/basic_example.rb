#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/weasy_rb"

puts "WeasyRb Basic Example"
puts "=" * 25

# Simple HTML content
html = <<~HTML
  <!DOCTYPE html>
  <html>
    <head>
      <title>Basic WeasyRb Example</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 40px auto;
          padding: 20px;
          line-height: 1.6;
        }
        h1 {
          color: #333;
          border-bottom: 2px solid #007acc;
          padding-bottom: 10px;
        }
        .info-box {
          background: #f4f4f4;
          padding: 15px;
          border-left: 4px solid #007acc;
          margin: 20px 0;
        }
        code {
          background: #f0f0f0;
          padding: 2px 4px;
          border-radius: 3px;
          font-family: monospace;
        }
      </style>
    </head>
    <body>
      <h1>Welcome to WeasyRb!</h1>

      <p>This is a basic example of converting HTML to PDF using WeasyRb.</p>

      <div class="info-box">
        <strong>Key Features:</strong>
        <ul>
          <li>Simple API: <code>WeasyRb.html_to_pdf(html, output_path)</code></li>
          <li>Full CSS support including modern features</li>
          <li>Docker-ready development environment</li>
          <li>Comprehensive error handling</li>
        </ul>
      </div>

      <h2>Getting Started</h2>
      <p>This PDF was generated on #{Time.now.strftime("%B %d, %Y at %I:%M %p")} using WeasyRb.</p>

      <p>To create your own PDFs:</p>
      <ol>
        <li>Install WeasyRb gem</li>
        <li>Create your HTML content</li>
        <li>Call <code>WeasyRb.html_to_pdf(html, "output.pdf")</code></li>
        <li>Enjoy your PDF!</li>
      </ol>
    </body>
  </html>
HTML

# Output path in examples directory
output_path = File.join(__dir__, "basic_example.pdf")

puts "Converting HTML to PDF..."

begin
  result = WeasyRb.html_to_pdf(html, output_path)

  puts "Success! PDF created at: #{File.basename(result)}"
  puts "Full path: #{File.expand_path(result)}"
  puts "File size: #{File.size(result)} bytes"
rescue StandardError => e
  puts "Error: #{e.message}"
  puts "Make sure to run this in Docker: docker-compose run --rm weasy_rb ruby examples/basic_example.rb"
end
