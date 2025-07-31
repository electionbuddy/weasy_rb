#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/weasy_rb"

puts "WeasyRb Decorated Demo"
puts "=" * 25

html = <<~HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title>WeasyRb Decorated Demo</title>
        <meta charset="UTF-8">
        <style>
          @page {
            size: A4;
            margin: 20mm;
          }

          body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            line-height: 1.6;
          }

          .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
          }

          h1 {
            color: #fff;
            margin-bottom: 20px;
            font-size: 2.2em;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
          }

          h2 {
            color: #fff;
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
            padding-bottom: 10px;
            margin-top: 25px;
            font-size: 1.3em;
          }

          .feature {
            margin: 12px 0;
            padding: 12px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 6px;
            border-left: 3px solid #ffd700;
          }

          .feature strong {
            color: #ffd700;
          }

          .code-block {
            background: rgba(0, 0, 0, 0.3);
            padding: 15px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            margin: 15px 0;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9em;
          }

          .stats {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            flex-wrap: wrap;
          }

          .stat {
            text-align: center;
            padding: 12px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 6px;
            flex: 1;
            margin: 3px;
            min-width: 100px;
          }

          .footer {
            margin-top: 25px;
            font-size: 0.85em;
            color: #ddd;
            text-align: center;
            padding-top: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.3);
          }

          /* Simple emoji support with fallbacks */
          .emoji {
            font-family: 'Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji', sans-serif;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1><span class="emoji">🚀</span> WeasyRb - Ruby + WeasyPrint</h1>

          <h2>Key Features</h2>

          <div class="feature">
            <strong>SOLID Principles:</strong> Clean, maintainable architecture following best practices.
          </div>

          <div class="feature">
            <strong>Docker Ready:</strong> Pre-configured development environment with all dependencies.
          </div>

          <div class="feature">
            <strong>Simple API:</strong> Just one method call: <code>WeasyRb.html_to_pdf(html, path)</code>
          </div>

          <div class="feature">
            <strong>Well Tested:</strong> Comprehensive test suite with 23+ tests.
          </div>

          <h2>Usage Example</h2>

          <div class="code-block">
  require "weasy_rb"

  html = "&lt;html&gt;&lt;body&gt;&lt;h1&gt;Hello!&lt;/h1&gt;&lt;/body&gt;&lt;/html&gt;"
  WeasyRb.html_to_pdf(html, "output.pdf")

  # With options
  options = { format: "A4", media_type: "print" }
  WeasyRb.html_to_pdf(html, "output.pdf", options)
          </div>

          <h2>Docker Commands</h2>

          <div class="stats">
            <div class="stat">
              <strong>Build</strong><br>
              <code>make build-and-test</code>
            </div>
            <div class="stat">
              <strong>Dev</strong><br>
              <code>make dev</code>
            </div>
            <div class="stat">
              <strong>Console</strong><br>
              <code>make console</code>
            </div>
            <div class="stat">
              <strong>Test</strong><br>
              <code>make test</code>
            </div>
          </div>

          <div class="footer">
            Generated on #{Time.now.strftime("%Y-%m-%d at %H:%M:%S")} using WeasyRb<br>
            <small>Demonstrates CSS gradients, shadows and modern layouts in PDF</small>
          </div>
        </div>
      </body>
    </html>
HTML

# Save PDF in examples directory
output_path = File.join(__dir__, "decorated_demo.pdf")

puts "Converting HTML to PDF..."
start_time = Time.now

begin
  result = WeasyRb.html_to_pdf(html, output_path)

  end_time = Time.now
  duration = ((end_time - start_time) * 1000).round(2)

  puts "Success! PDF created at: #{File.basename(result)}"
  puts "File size: #{File.size(result)} bytes"
  puts "Conversion time: #{duration}ms"
  puts "Full path: #{File.expand_path(result)}"
rescue StandardError => e
  puts "Error: #{e.message}"
  puts "Make sure to run this in Docker: docker-compose run --rm weasy_rb ruby examples/decorated_demo.rb"
end
