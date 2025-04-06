# Layer that builds the site
FROM ruby:3.1 as builder

# Install Jekyll
RUN gem install jekyll bundler

# Create a new directory for the project
WORKDIR /usr/src/app

# Copy the Gemfile
COPY Gemfile ./

# Install the gems
RUN bundle install

# Copy the rest of the project files
COPY . .

# Build the Jekyll site
RUN JEKYLL_ENV=production bundle exec jekyll build

# Caddy layer and expose the site
FROM caddy:2-alpine

# Copy the built site from the previous layer
COPY --from=builder /usr/src/app/_site /usr/share/caddy

# Copy the Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile
