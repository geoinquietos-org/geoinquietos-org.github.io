# Just https://github.com/casey/just

default: build stop run

# Builds the website into a container
build:
  docker build -t geoinquietos.org .

# Run the container
run:
  docker run --rm \
    --name geoinquietos \
    -p 8090:80 \
    -v /tmp/caddy_data:/data \
    geoinquietos.org

# Stop the container
stop:
  docker stop geoinquietos || true
