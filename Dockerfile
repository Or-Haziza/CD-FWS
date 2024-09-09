# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy the static files from the current directory to the Nginx HTML directory
COPY . /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Define the default command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
