# Use official nginx image 
FROM nginx:alpine

# Install apache2-utils for htpasswd command
RUN apk add --no-cache apache2-utils

# Create directories
RUN mkdir -p /usr/share/nginx/html/tiles \
    /usr/share/nginx/html/font \
    /usr/share/nginx/html/styles

# Copy nginx configuration
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy tile data and configuration
COPY tiles /usr/share/nginx/html/tiles
COPY font /usr/share/nginx/html/font
COPY styles /usr/share/nginx/html/styles
COPY style.json /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]