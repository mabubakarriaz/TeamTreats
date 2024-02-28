# Use a lightweight base image; in this case, Alpine Linux
FROM alpine:3.12

# Install any necessary dependencies (none needed for echo)
# RUN apk add --no-cache <your-dependencies-here>

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Specify the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
