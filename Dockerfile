# Environment to install Flutter and build web
FROM debian:latest AS build-env

# Install all needed stuff
RUN apt-get update && \
    apt-get install -y curl git unzip

# Define variables
ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=3.13.9
ARG APP=/app/

# Clone Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
# Change dir to the current Flutter folder and make a checkout to the specific version
RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

# Setup the Flutter path as an environmental variable
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# Start to run Flutter commands
# Doctor to see if all was installed ok
RUN flutter doctor -v

# Create a folder to copy source code
RUN mkdir $APP
# Copy source code to folder
COPY . $APP
# Set up the new folder as the working directory
WORKDIR $APP

# Run build: 1 - clean, 2 - pub get, 3 - build web
RUN flutter clean
RUN flutter pub get
RUN flutter build web

# Once here, the app will be compiled and ready to deploy

# Use Nginx to deploy
FROM nginx:1.21.0-alpine

# Copy the info of the built web app to Nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Copy the Nginx configuration file for reverse proxy
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose and run Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
