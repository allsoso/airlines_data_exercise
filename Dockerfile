FROM postgres:latest as postgres

# Set the working directory
WORKDIR /app

# Copy the script into the container
COPY install_pgloader.sh /app/install_pgloader.sh

# Grant execution permissions to the script
RUN chmod +x /app/install_pgloader.sh

# Run the script to install pgloader
RUN /app/install_pgloader.sh

# Expose the default Postgres port
EXPOSE 5432

# Retain the original Postgres entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Set the default command
CMD ["postgres"]
