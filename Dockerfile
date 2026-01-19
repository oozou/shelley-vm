FROM ghcr.io/boldsoftware/exeuntu:main-fe4664e

# Install Shelley
RUN curl -Lo /usr/local/bin/shelley \
    "https://github.com/boldsoftware/shelley/releases/latest/download/shelley_linux_$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')" \
    && chmod +x /usr/local/bin/shelley

# Create data directory for persistence
RUN mkdir -p /data

# Expose Shelley port and webapp port
EXPOSE 9000 8000

# Start Shelley on container boot
COPY start-shelley.sh /usr/local/bin/start-shelley.sh
RUN chmod +x /usr/local/bin/start-shelley.sh

CMD ["/usr/local/bin/start-shelley.sh"]
