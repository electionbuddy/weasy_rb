# WeasyRb Examples

This directory contains example scripts demonstrating WeasyRb functionality.

# WeasyRb Examples

This directory contains two example scripts demonstrating WeasyRb functionality.

## 📁 Files

### `basic_example.rb` 
A simple, minimal demonstration of WeasyRb:
- Clean, straightforward HTML to PDF conversion
- Basic CSS styling
- Simple error handling
- No decorative elements

**Generated Output:** `basic_example.pdf` (~12KB)

### `decorated_demo.rb`
A more sophisticated demonstration showcasing WeasyPrint's capabilities:
- Modern CSS features (gradients, shadows, blur effects)
- Professional layout and typography
- Subtle emoji support with proper font fallbacks
- Performance benchmarking
- Advanced styling techniques

**Generated Output:** `decorated_demo.pdf` (~20KB)

## 🚀 Running Examples

### Using Docker (Recommended)
```bash
# Run the basic example
docker-compose run --rm weasy_rb ruby examples/basic_example.rb

# Run the decorated demo
docker-compose run --rm weasy_rb ruby examples/decorated_demo.rb

# Interactive exploration
docker-compose run --rm console
```

### Using Make Commands
```bash
# Run demo with convenient make command
make dev
# Then inside container:
ruby examples/docker_demo.rb
```

## 📖 Viewing Generated PDFs

The examples generate PDF files that you can open with any PDF viewer:

- **Linux:** `xdg-open examples/weasy_rb_demo.pdf`
- **macOS:** `open examples/weasy_rb_demo.pdf` 
- **Windows:** `start examples/weasy_rb_demo.pdf`
- **VS Code:** Right-click the PDF file and select "Open with > Default Application"

## ✨ What You'll See

### Basic Example
- Clean, minimal layout
- Simple CSS styling  
- Straightforward content structure
- Professional but understated design

### Decorated Demo
- Modern CSS gradients and visual effects
- Subtle emoji support (just one 🚀 in the title)
- Professional typography and spacing
- Advanced layout techniques
- Performance metrics and timing

Both examples showcase WeasyPrint's ability to handle different levels of CSS complexity while maintaining excellent PDF output quality.
