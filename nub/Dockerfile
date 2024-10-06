# Step 1: Use Node.js as the base image
FROM node:18

# Step 2: Install pnpm globally
RUN npm install -g pnpm

# Step 3: Set the working directory inside the container
WORKDIR /usr/src/app

# Step 4: Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# Step 5: Install dependencies using pnpm
RUN pnpm install

# Step 6: Copy the rest of the application code
COPY . .

# Step 7: Expose the port on which the NestJS app will run
EXPOSE 3000

# Step 8: Start the application in development mode
CMD ["pnpm", "run", "start:dev"]
