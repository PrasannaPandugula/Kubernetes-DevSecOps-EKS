FROM node:16

WORKDIR /app

COPY package*.json ./

#install project dependencies
RUN npm install

# Copy source code to container
COPY . .

#build the react app
RUN npm run build

EXPOSE 3000

# start the react app when container starts
CMD ["npm", "start"]