FROM alpine:latest

WORKDIR /usr/local/bin

# Copy the script
COPY ./ ./

# Ensure the script has the right permissions
RUN chmod +x *.sh

EXPOSE 2220

# Run the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
