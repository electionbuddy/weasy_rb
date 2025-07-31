# Docker Development Environment for WeasyRb

This directory contains Docker configuration files to make development easier by providing a consistent environment with all dependencies pre-installed.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

### Build the Docker image
```bash
docker-compose build
```

### Run tests
```bash
docker-compose run test
```

### Start interactive development shell
```bash
docker-compose run weasy_rb
```

### Start Ruby console with gem loaded
```bash
docker-compose run console
```

## Development Workflow

1. **Make changes** to your code in your host environment
2. **Run tests** using Docker:
   ```bash
   docker-compose run test
   ```
3. **Debug interactively**:
   ```bash
   docker-compose run weasy_rb bash
   # Inside container:
   bundle exec rake test
   bin/console
   ```

## What's Included

The Docker environment includes:
- Ruby 3.4
- WeasyPrint (Python library)
- All system dependencies for WeasyPrint
- All Ruby gem dependencies
- Development tools

## Container Commands

### Run specific test files
```bash
docker-compose run weasy_rb bundle exec ruby test/test_converter.rb
```

### Run RuboCop
```bash
docker-compose run weasy_rb bundle exec rubocop
```

### Install new gems
```bash
docker-compose run weasy_rb bundle install
```

### Generate a test PDF
```bash
docker-compose run weasy_rb ruby -e "
require './lib/weasy_rb'
html = '<html><body><h1>Hello from Docker!</h1></body></html>'
WeasyRb.html_to_pdf(html, '/tmp/test.pdf')
puts 'PDF created at /tmp/test.pdf'
"
```

## Troubleshooting

### Permission Issues
If you encounter permission issues with mounted volumes, you may need to adjust the user in the Dockerfile or run with appropriate permissions.

### WeasyPrint Issues
The Docker image includes all necessary system dependencies for WeasyPrint. If you encounter issues, check that the container has access to the required fonts and libraries.

### Bundle Cache
The docker-compose.yml uses a named volume for bundle cache to speed up subsequent builds and runs.
