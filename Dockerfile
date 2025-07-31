# Use official Ruby image as base
FROM ruby:3.4-slim

# Install system dependencies required for WeasyPrint
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    git \
    libpango-1.0-0 \
    libharfbuzz0b \
    libpangoft2-1.0-0 \
    libfontconfig1 \
    libcairo-gobject2 \
    libgdk-pixbuf-2.0-0 \
    shared-mime-info \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Install WeasyPrint via pip
RUN pip3 install --break-system-packages weasyprint

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock weasy_rb.gemspec ./
COPY lib/weasy_rb/version.rb ./lib/weasy_rb/

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application
COPY . .

# Create a non-root user for development
RUN useradd -m -s /bin/bash developer && \
    chown -R developer:developer /app
USER developer

# Default command
CMD ["bundle", "exec", "rake", "test"]
