# Use a Node.js base image to build the React app
FROM node:14 as build-stage

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app's source code to the container
COPY . .

# Build the React app
RUN npm run build

# Use Nginx as a lightweight web server to serve the built React app
FROM nginx:alpine

# Copy the built React app from the build-stage container to the Nginx container
COPY --from=build-stage /app/build /usr/share/nginx/html

# Expose port 80 to allow incoming HTTP traffic
EXPOSE 80

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
