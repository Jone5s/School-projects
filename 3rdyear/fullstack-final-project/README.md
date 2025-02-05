[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/qCtVf2Dd)

# Final Project
Web Programming - Final Project

# Description
My website, DriveBids, is a car auction platform. It offers users the ability to bid on cars, create new auction listings, and view or delete their own auctions. Additional features include sorting auctions by price, time remaining, and make of the car. When users create a new auction, they set an end time for it. The site then calculates the remaining time to this end date and displays a real-time countdown.

The auctions have an overview card which show basic info on that auction, the user can view a more detailed modal about the auction, if desired.

## Getting Started

### Clone the Repository
```bash
git clone https://github.com/TiTe-5G00EV16-3003/2024-final-project-Jone5s.git
```
```bash
cd 2024-final-project-Jone5s
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

## Problems and shortcomings
I couldn´t for the life on me get the backend deployment working. The pipelines run flawlesly and the frontend deploys as it should. I pinpointed the problem to the mysql database, because the /health route works (http://172.16.4.178:5002/health). But after trying everything I could think of and everything suggested in slack, google and chagpt, nothing worked. Now I just dont have the time to try to fix it. I´m very disappointed I couldnt get it working 😢

The frontend runs at http://172.16.4.178:80, but its not of much use, as it crashes straight away, as it tries to fetch from the backend that doesn´t work.
