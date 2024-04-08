FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json . 
RUN npm install
COPY . .
RUN npm run build 

# Run phase 
FROM nginx
# Take the previous build from the last step 'builder'
# locate where the build directory is in our container
# point it towards nginx
COPY --from=builder /app/build /user/share/nginx/html