# Use official nginx image
FROM nginx:alpine

# Install apache2-utils for htpasswd command
RUN apk add --no-cache apache2-utils

# Create directory for basic auth file
RUN mkdir -p /etc/nginx/auth

# Create basic auth file (you'll need to change these credentials)
RUN htpasswd -bc /etc/nginx/auth/.htpasswd dasiot dasiot-for-ba_ckend

# Create directories for tiles
RUN mkdir -p /usr/share/nginx/html/tiles \
    /usr/share/nginx/html/font \
    /usr/share/nginx/html/styles

# Copy nginx configuration
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy your tile data (adjust paths as needed)
COPY tiles /usr/share/nginx/html/tiles
COPY font /usr/share/nginx/html/font
COPY styles /usr/share/nginx/html/styles

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]