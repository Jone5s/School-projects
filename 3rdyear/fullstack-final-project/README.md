[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/qCtVf2Dd)

# Final Project
Web Programming - Final Project

# Description
My website, DriveBids, is a car auction platform. It offers users the ability to bid on cars, create new auction listings, and view or delete their own auctions. Additional features include sorting auctions by price, time remaining, and make of the car. When users create a new auction, they set an end time for it. The site then calculates the remaining time to this end date and displays a real-time countdown.

The auctions have an overview card which show basic info on that auction, the user can view a more detailed modal about the auction, if desired.

## Getting Started

### Clone the Repository
```bash
cd fullstack-final-project
```

### Create .env files
backend folder:
```plaintext
JWT_KEY='my_test_secret_key'
PORT=5000
MYSQL_HOST='127.0.0.1'
MYSQL_USER='root'
MYSQL_PASSWORD='auction_password'
MYSQL_DATABASE='auction_db'
MYSQL_PORT='3306'
```
Frontend folder:
```plaintext
VITE_API_URL='http://localhost:5000'
```
### Docker-compose for the database
```bash 
docker-compose up
```

### Start backend server
```bash
cd backend
npm install
npm run dev
```
This command will start the backend server. 

### Start frontend server
```bash
cd ..
cd frontend
npm install
npm run dev
```
This command will start the frontend development server.


## Accessing the Application
Once both the backend and frontend servers are running, you can access the application from http://localhost:5173
