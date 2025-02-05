CREATE TABLE IF NOT EXISTS `users` (
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password_hash` VARCHAR(60) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

CREATE TABLE IF NOT EXISTS `ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `make` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `image` varchar(200),
  `price` int(7),
  `description` varchar(500),
  `hp` int(4),
  `fueltype` varchar(10),
  `displacement` varchar(4),
  `end_time` DATETIME,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creatorId` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`creatorId`) REFERENCES `users`(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

INSERT INTO `users` (id, name, email, password_hash) VALUES 
('uuid-1234-5678-9012-3456', 'John Doe', 'john.doe@example.com', 'hashed_password'),
('uuid-1234-5678-9012-3457', 'Jane Smith', 'jane.smith@example.com', 'hashed_password');


INSERT INTO `ads` (make, model, image, price, description, hp, fueltype, displacement, end_time, creatorId) VALUES
('Toyota', 'Corolla', 'http://localhost:5000/images/corolla.png', 20000, 'Reliable family car', 132, 'Petrol', '1.8', '2024-12-25 15:00:00', 'uuid-1234-5678-9012-3456'),
('Ford', 'Mustang', 'http://localhost:5000/images/mustang.png', 35000, 'Powerful sports car', 450, 'Petrol', '5.0', '2024-12-30 20:00:00', 'uuid-1234-5678-9012-3456'),
('BMW', 'M5', 'http://localhost:5000/images/m5.png', 65000, 'High-performance vehicle', 473, 'Petrol', '3.0', '2024-05-15 12:00:00', 'uuid-1234-5678-9012-3456'),
('Honda', 'Civic', 'http://localhost:5000/images/civic.png', 2000, 'Efficient and reliable', 158, 'Petrol', '2.0', '2024-11-01 18:00:00', 'uuid-1234-5678-9012-3456'),
('BMW', 'E30', 'http://localhost:5000/images/e30.png', 22000, 'Classic performance car', 192, 'Petrol', '2.3', '2024-10-15 16:00:00', 'uuid-1234-5678-9012-3456'),
('BMW', 'E46', 'http://localhost:5000/images/e46.png', 25000, 'Iconic sports sedan', 240, 'Petrol', '3.0', '2024-12-12 14:00:00', 'uuid-1234-5678-9012-3456'),
('Suzuki', 'Jimny', 'http://localhost:5000/images/jimmy.png', 15000, 'Compact off-road capability', 102, 'Petrol', '1.5', '2024-11-28 17:00:00', 'uuid-1234-5678-9012-3457'),
('Lada', '2200', 'http://localhost:5000/images/lada.png', 8000, 'Rugged but durable', 83, 'Petrol', '1.6', '2024-11-11 13:00:00', 'uuid-1234-5678-9012-3457'),
('Mazda', '6', 'http://localhost:5000/images/mazda.png', 900, 'Seen its best days', 138, 'Petrol', '2.0', '2024-10-31 19:00:00', 'uuid-1234-5678-9012-3457'),
('Mercedes-Benz', 'E250', 'http://localhost:5000/images/mersu.png', 9000, 'Stylish classic', 150, 'Petrol', '2.5', '2024-11-05 21:00:00', 'uuid-1234-5678-9012-3457'), 
('Porsche', '911', 'http://localhost:5000/images/porsche.png', 90000, 'Timeless sports car', 379, 'Petrol', '3.0', '2024-12-20 22:00:00', 'uuid-1234-5678-9012-3457'),
('Land Rover', 'Range Rover', 'http://localhost:5000/images/range.png', 85000, 'Luxury SUV, car of the aristocrats', 220, 'Diesel', '3.0', '2024-05-01 10:00:00', 'uuid-1234-5678-9012-3457'),
('Volvo', '740', 'http://localhost:5000/images/volvo.png', 4000, 'Safe and spacious classic', 250, 'Diesel', '2.5', '2024-11-30 15:30:00', 'uuid-1234-5678-9012-3457');
