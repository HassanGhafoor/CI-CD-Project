# Step 1: Use Node.js as the base image
FROM node:16-alpine as build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the entire React app
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use Nginx as the web server
FROM nginx:alpine

# Step 8: Copy the build files to Nginx's default directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start Nginx
CMD ["nginx", "-g", "daemon off;"]
