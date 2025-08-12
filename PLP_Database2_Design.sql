/* Create the database */
CREATE DATABASE IF NOT EXISTS salesDB;

/* Switch to the salesDB database */
USE salesDB;

/* Drop existing tables */
DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS productlines;

/* Create the tables */
CREATE TABLE productlines (
  productLine varchar(50),
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription mediumtext,
  image mediumblob,
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode varchar(15),
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription text NOT NULL,
  quantityInStock smallint(6) NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);

CREATE TABLE offices (
  officeCode varchar(10),
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
);

CREATE TABLE employees (
  employeeNumber int,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);

CREATE TABLE customers (
  customerNumber int,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
  customerNumber int,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orders (
  orderNumber int,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customerNumber int NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber int,
  productCode varchar(15) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint(6) NOT NULL,
  PRIMARY KEY (orderNumber,productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  FOREIGN KEY (productCode) REFERENCES products (productCode)
);


/* Inserting data into productlines */
insert into productlines(productLine,textDescription,htmlDescription,image) values
('Classic Cars','Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL),
('Motorcycles','Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.',NULL,NULL),
('Planes','Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.',NULL,NULL),
('Ships','The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.',NULL,NULL),
('Trains','Model trains are a rewarding hobby for enthusiasts of all ages. Whether you''re looking for collectible wooden trains, electric streetcars or locomotives, you''ll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.',NULL,NULL),
('Trucks and Buses','The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.',NULL,NULL),
('Vintage Cars','Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL);

/* Inserting data into products */
insert into products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP) values
('S10_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70'),
('S10_1949','1952 Alpine Renault 1300','Classic Cars','1:10','Classic Metal Creations','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',7305,'98.58','214.30'),
('S10_2016','1996 Moto Guzzi 1100i','Motorcycles','1:10','Highway 66 Mini Classics','Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',6625,'68.99','118.94'),
('S10_4698','2003 Harley-Davidson Eagle Drag Bike','Motorcycles','1:10','Red Start Diecast','Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand\r\n, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine',5582,'91.02','193.66'),
('S10_4757','1972 Alfa Romeo GTA','Classic Cars','1:10','Motor City Art Classics','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',3252,'85.68','136.00'),
('S10_4962','1962 LanciaA Delta 16V','Classic Cars','1:10','Second Gear Diecast','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',6791,'103.42','147.74'),
('S12_1099','1968 Ford Mustang','Classic Cars','1:12','Autoart Studio Design','Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.',68,'95.34','194.57'),
('S12_1108','2001 Ferrari Enzo','Classic Cars','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',3619,'95.59','207.80'),
('S12_1666','1958 Setra Bus','Trucks and Buses','1:12','Welly Diecast Productions','Model features 30 windows, skylights & glare resistant glass, working steering system, original logos',1579,'77.90','136.67'),
('S12_2823','2002 Suzuki XREO','Motorcycles','1:12','Unimax Art Galleries','Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',9997,'66.27','150.62'),
('S12_3148','1969 Corvair Monza','Classic Cars','1:18','Welly Diecast Productions','1:18 scale die-cast about 10\" long doors open, hood opens, trunk opens and wheels roll',6906,'89.14','151.08'),
('S12_3380','1968 Dodge Charger','Classic Cars','1:12','Welly Diecast Productions','1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black',9123,'75.16','117.44'),
('S12_3891','1969 Ford Falcon','Classic Cars','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',1049,'83.05','173.02'),
('S12_3990','1970 Plymouth Hemi Cuda','Classic Cars','1:12','Studio M Art Models','Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.',5663,'31.92','79.80'),
('S12_4473','1957 Chevy Pickup','Trucks and Buses','1:12','Exoto Designs','1:12 scale die-cast about 20\" long Hood opens, Rubber wheels',6125,'55.70','118.50'),
('S12_4675','1969 Dodge Charger','Classic Cars','1:12','Welly Diecast Productions','Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.',7323,'58.73','115.16'),
('S18_1097','1940 Ford Pickup Truck','Trucks and Buses','1:18','Studio M Art Models','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',2613,'58.33','116.67'),
('S18_1129','1993 Mazda RX-7','Classic Cars','1:18','Highway 66 Mini Classics','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.',3975,'83.51','141.54'),
('S18_1342','1937 Lincoln Berline','Vintage Cars','1:18','Motor City Art Classics','Features opening engine cover, doors, trunk, and fuel filler cap. Color black',8693,'60.62','102.74'),
('S18_1367','1936 Mercedes-Benz 500K Special Roadster','Vintage Cars','1:18','Studio M Art Models','This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.',8635,'24.26','53.91'),
('S18_1589','1965 Aston Martin DB5','Classic Cars','1:18','Classic Metal Creations','Die-cast model of the silver 1965 Aston Martin DB5 in silver. This model includes full wire wheels and doors that open with fully detailed passenger compartment. In 1:18 scale, this model measures approximately 10 inches/20 cm long.',9042,'65.96','124.44'),
('S18_1662','1980s Black Hawk Helicopter','Planes','1:18','Red Start Diecast','1:18 scale replica of actual Army''s UH-60L BLACK HAWK Helicopter. 100% hand-assembled. Features rotating rotor blades, propeller blades and rubber wheels.',5330,'77.27','157.69'),
('S18_1749','1917 Grand Touring Sedan','Vintage Cars','1:18','Welly Diecast Productions','This 1:18 scale replica of the 1917 Grand Touring car has all the features you would expect from museum quality reproductions: all four doors and bi-fold hood opening, detailed engine and instrument panel, chrome-look trim, and tufted upholstery, all topped off with a factory baked-enamel finish.',2724,'86.70','170.00'),
('S18_1889','1948 Porsche 356-A Roadster','Classic Cars','1:18','Gearbox Collectibles','This precision die-cast replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',8826,'53.90','77.00'),
('S18_1984','1995 Honda Civic','Classic Cars','1:18','Min Lin Diecast','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color yellow.',9772,'93.89','142.25'),
('S18_2238','1998 Chrysler Plymouth Prowler','Classic Cars','1:18','Gearbox Collectibles','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',4724,'101.51','163.73'),
('S18_2248','1911 Ford Town Car','Vintage Cars','1:18','Motor City Art Classics','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system.',540,'33.30','60.54'),
('S18_2319','1964 Mercedes Tour Bus','Trucks and Buses','1:18','Unimax Art Galleries','Exact replica. 100+ parts. working steering system, original logos',8258,'74.86','122.73'),
('S18_2325','1932 Model A Ford J-Coupe','Vintage Cars','1:18','Autoart Studio Design','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine',9354,'58.48','127.13'),
('S18_2432','1926 Ford Fire Engine','Trucks and Buses','1:18','Carousel DieCast Legends','Gleaming red handsome appearance. Everything is here the fire hoses, ladder, axes, bells, lanterns, ready to fight any inferno.',2018,'24.92','60.77'),
('S18_2581','P-51-D Mustang','Planes','1:72','Gearbox Collectibles','Has retractable wheels and comes with a stand',992,'49.00','84.48'),
('S18_2625','1936 Harley Davidson El Knucklehead','Motorcycles','1:18','Welly Diecast Productions','Intricately detailed with chrome accents and trim, official die-struck logos and baked enamel finish.',4357,'24.23','60.57'),
('S18_2795','1928 Mercedes-Benz SSK','Vintage Cars','1:18','Gearbox Collectibles','This 1:18 replica features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine. Color black.',548,'72.56','168.75'),
('S18_2870','1999 Indy 500 Monte Carlo SS','Classic Cars','1:18','Red Start Diecast','Features include opening and closing doors. Color: Red',8164,'56.76','132.00'),
('S18_2949','1913 Ford Model T Speedster','Vintage Cars','1:18','Carousel DieCast Legends','This 250 part reproduction includes moving handbrakes, clutch, throttle and foot pedals, squeezable horn, detailed wired engine, removable water, gas, and oil cans, pivoting monocle windshield, all topped with a baked enamel red finish. Each replica comes with an Owners Title and Certificate of Authenticity. Color red.',4189,'60.78','101.31'),
('S18_2957','1934 Ford V8 Coupe','Vintage Cars','1:18','Min Lin Diecast','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',5649,'34.35','62.46'),
('S18_3029','1999 Yamaha Speed Boat','Ships','1:18','Min Lin Diecast','Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',4259,'51.61','86.02'),
('S18_3136','18th Century Vintage Horse Carriage','Vintage Cars','1:18','Red Start Diecast','Hand crafted diecast-like metal horse carriage is re-created in about 1:18 scale of antique horse carriage. This antique style metal Stagecoach is all hand-assembled with many different parts.\r\n\r\nThis collectible metal horse carriage is painted in classic Red, and features turning steering wheel and is entirely hand-finished.',5992,'60.74','104.72'),
('S18_3140','1903 Ford Model A','Vintage Cars','1:18','Unimax Art Galleries','Features opening trunk, working steering system',3913,'68.30','136.59'),
('S18_3232','1992 Ferrari 360 Spider red','Classic Cars','1:18','Unimax Art Galleries','his replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',8347,'77.90','169.34'),
('S18_3233','1985 Toyota Supra','Classic Cars','1:18','Highway 66 Mini Classics','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',7733,'57.01','107.57'),
('S18_3259','Collectable Wooden Train','Trains','1:18','Carousel DieCast Legends','Hand crafted wooden toy train set is in about 1:18 scale, 25 inches in total length including 2 additional carts, of actual vintage train. This antique style wooden toy train model set is all hand-assembled with 100% wood.',6450,'67.56','100.84'),
('S18_3278','1969 Dodge Super Bee','Classic Cars','1:18','Min Lin Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',1917,'49.05','80.41'),
('S18_3320','1917 Maxwell Touring Car','Vintage Cars','1:18','Exoto Designs','Features Gold Trim, Full Size Spare Tire, Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',7913,'57.54','99.21'),
('S18_3482','1976 Ford Gran Torino','Classic Cars','1:18','Gearbox Collectibles','Highly detailed 1976 Ford Gran Torino "Starsky and Hutch" diecast model. Very well constructed and painted in red and white patterns.',9127,'73.49','146.99'),
('S18_3685','1948 Porsche Type 356 Roadster','Classic Cars','1:18','Gearbox Collectibles','This model features working front and rear suspension on accurately replicated and actuating shock absorbers as well as opening engine cover, rear stabilizer flap, and 4 opening doors.',8990,'62.16','141.28'),
('S18_3782','1957 Vespa GS150','Motorcycles','1:18','Studio M Art Models','Features rotating wheels , working kick stand. Comes with stand.',7689,'32.95','62.17'),
('S18_3856','1941 Chevrolet Special Deluxe Cabriolet','Vintage Cars','1:18','Exoto Designs','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system, leather upholstery. Color black.',2378,'64.58','105.87'),
('S18_4027','1970 Triumph Spitfire','Classic Cars','1:18','Min Lin Diecast','Features include opening and closing doors. Color: White.',5545,'91.92','143.62'),
('S18_4409','1932 Alfa Romeo 8C2300 Spider Sport','Vintage Cars','1:18','Exoto Designs','This 1:18 scale precision die cast replica features the 6 front headlights of the original, plus a detailed version of the 142 horsepower straight 8 engine, dual spares and their famous comprehensive dashboard. Color black.',6553,'43.26','92.03'),
('S18_4522','1904 Buick Runabout','Vintage Cars','1:18','Exoto Designs','Features opening trunk, working steering system',8290,'52.66','87.77'),
('S18_4600','1940s Ford truck','Trucks and Buses','1:18','Motor City Art Classics','This 1940s Ford Pick-Up truck is re-created in 1:18 scale of original 1940s Ford truck. This antique style metal 1940s Ford Flatbed truck is all hand-assembled. This collectible 1940''s Pick-Up truck is painted in classic dark green color, and features rotating wheels.',3128,'84.76','121.08'),
('S18_4668','1939 Cadillac Limousine','Vintage Cars','1:18','Studio M Art Models','Features completely detailed interior including Velvet flocked drapes,deluxe wood grain floor, and a wood grain casket with seperate chrome handles',6645,'23.14','50.31'),
('S18_4721','1957 Corvette Convertible','Classic Cars','1:18','Classic Metal Creations','1957 die cast Corvette Convertible in Roman Red with white sides and whitewall tires. 1:18 scale quality die-cast with detailed engine and underbvody. Now you can own The Classic Corvette.',1249,'69.93','148.80'),
('S18_4933','1957 Ford Thunderbird','Classic Cars','1:18','Studio M Art Models','This 1:18 scale precision die-cast replica, with its optional porthole hardtop and factory baked-enamel Thunderbird Bronze finish, is a 100% accurate rendition of this American classic.',3209,'34.21','71.27'),
('S24_1046','1970 Chevy Chevelle SS 454','Classic Cars','1:24','Unimax Art Galleries','This model features rotating wheels, working streering system and opening doors. All parts are particularly delicate due to their precise scale and require special care and attention. It should not be picked up by the doors, roof, hood or trunk.',1005,'49.24','73.49'),
('S24_1444','1970 Dodge Coronet','Classic Cars','1:24','Highway 66 Mini Classics','1:24 scale die-cast about 18" long doors open, hood opens and rubber wheels',4074,'32.37','57.80'),
('S24_1578','1997 BMW R 1100 S','Motorcycles','1:24','Autoart Studio Design','Detailed scale replica with working suspension and constructed from over 70 parts',7003,'60.86','112.70'),
('S24_1628','1966 Shelby Cobra 427 S/C','Classic Cars','1:24','Carousel DieCast Legends','This diecast model of the 1966 Shelby Cobra 427 S/C includes many authentic details and operating parts. The 1:24 scale model of this iconic lighweight sports car from the 1960s comes in silver and it''s own display case.',8197,'29.18','50.31'),
('S24_1785','1928 British Royal Navy Airplane','Planes','1:24','Classic Metal Creations','Official logos and insignias',3627,'66.74','109.42'),
('S24_1937','1939 Chevrolet Deluxe Coupe','Vintage Cars','1:24','Motor City Art Classics','This 1:24 scale die-cast replica of the 1939 Chevrolet Deluxe Coupe has the same classy look as the original. Features opening trunk, hood and doors and a showroom quality baked enamel finish.',7332,'22.57','33.19'),
('S24_2000','1960 BSA Gold Star DBD34','Motorcycles','1:24','Highway 66 Mini Classics','Detailed scale replica with working suspension and constructed from over 70 parts',15,'37.32','76.17'),
('S24_2011','18th century schooner','Ships','1:24','Carousel DieCast Legends','All wood with canvas sails. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with 4 masts, all square-rigged.',1898,'82.34','122.89'),
('S24_2022','1938 Cadillac V-16 Presidential Limousine','Vintage Cars','1:24','Classic Metal Creations','This 1:24 scale precision die cast replica of the 1938 Cadillac V-16 Presidential Limousine has all the details of the original, from the flags on the front to an opening back seat compartment complete with telephone and rifle. Features factory baked-enamel black finish, hood goddess ornament, working jump seats.',2847,'20.61','44.80'),
('S24_2300','1962 Volkswagen Microbus','Trucks and Buses','1:24','Autoart Studio Design','This 1:18 scale die cast replica of the 1962 Microbus is loaded with features: A working steering system, opening front doors and tailgate, and famous two-tone factory baked enamel finish, are all topped of by the sliding, real fabric, sunroof.',2327,'61.34','127.79'),
('S24_2360','1982 Ducati 900 Monster','Motorcycles','1:24','Highway 66 Mini Classics','Features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand',6840,'47.10','69.26'),
('S24_2766','1949 Jaguar XK 120','Classic Cars','1:24','Classic Metal Creations','Precision-engineered from original Jaguar specification in perfect scale ratio. Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',2350,'47.25','90.87'),
('S24_2840','1958 Chevy Corvette Limited Edition','Classic Cars','1:24','Carousel DieCast Legends','The operating parts of this 1958 Chevy Corvette Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, working streering, opening doors and trunk. Color dark green.',2542,'15.91','35.36'),
('S24_2841','1900s Vintage Bi-Plane','Planes','1:24','Autoart Studio Design','Hand crafted diecast-like metal bi-plane is re-created in about 1:24 scale of antique pioneer airplane. All hand-assembled with many different parts. Hand-painted in classic yellow and features correct markings of original airplane.',5942,'34.25','68.51'),
('S24_2887','1952 Citroen-15CV','Classic Cars','1:24','Exoto Designs','Precision crafted hand-assembled 1:18 scale reproduction of the 1952 15CV, with its independent spring suspension, working steering system, opening doors and hood, detailed engine and instrument panel, all topped of with a factory fresh baked enamel finish.',1452,'72.82','117.44'),
('S24_2972','1982 Lamborghini Diablo','Classic Cars','1:24','Second Gear Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',7723,'16.24','37.76'),
('S24_3151','1912 Ford Model T Delivery Wagon','Vintage Cars','1:24','Min Lin Diecast','This model features chrome trim and grille, opening hood, opening doors, opening trunk, detailed engine, working steering system. Color white.',9173,'46.91','88.51'),
('S24_3191','1969 Chevrolet Camaro Z28','Classic Cars','1:24','Exoto Designs','1969 Z/28 Chevy Camaro 1:24 scale replica. The operating parts of this limited edition 1:24 scale diecast model car 1969 Chevy Camaro Z28- hood, trunk, wheels, streering, suspension and doors- are particularly delicate due to their precise scale and require special care and attention.',4695,'50.51','85.61'),
('S24_3371','1971 Alpine Renault 1600s','Classic Cars','1:24','Welly Diecast Productions','This 1971 Alpine Renault 1600s replica Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',7995,'38.58','61.23'),
('S24_3420','1937 Horch 930V Limousine','Vintage Cars','1:24','Autoart Studio Design','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system',2902,'26.30','65.75'),
('S24_3432','2002 Chevy Corvette','Classic Cars','1:24','Gearbox Collectibles','The operating parts of this limited edition Diecast 2002 Chevy Corvette 50th Anniversary Pace car Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, poseable streering, opening doors and trunk.',9446,'62.11','107.08'),
('S24_3816','1940 Ford Delivery Sedan','Vintage Cars','1:24','Carousel DieCast Legends','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System. Color black.',6621,'48.64','83.86'),
('S24_3856','1956 Porsche 356A Coupe','Classic Cars','1:18','Classic Metal Creations','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',6600,'98.30','140.43'),
('S24_3949','Corsair F4U ( Bird Cage)','Planes','1:24','Second Gear Diecast','Has retractable wheels and comes with a stand. Official logos and insignias.',6812,'29.34','68.24'),
('S24_3969','1936 Mercedes Benz 500k Roadster','Vintage Cars','1:24','Red Start Diecast','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system and rubber wheels. Color black.',2081,'21.75','41.03'),
('S24_4048','1992 Porsche Cayenne Turbo Silver','Classic Cars','1:24','Exoto Designs','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',6582,'69.78','118.28'),
('S24_4258','1936 Chrysler Airflow','Vintage Cars','1:24','Second Gear Diecast','Features opening trunk, working steering system. Color dark green.',4710,'57.46','97.39'),
('S24_4278','1900s Vintage Tri-Plane','Planes','1:24','Unimax Art Galleries','Hand crafted diecast-like metal Triplane is Re-created in about 1:24 scale of antique pioneer airplane. This antique style metal triplane is all hand-assembled with many different parts.',2756,'36.23','72.45'),
('S24_4620','1961 Chevrolet Impala','Classic Cars','1:18','Classic Metal Creations','This 1:18 scale precision die-cast reproduction of the 1961 Chevrolet Impala has all the features-doors, hood and trunk that open; detailed 409 cubic-inch engine; chrome dashboard and stick shift, two-tone interior; working steering system; all topped of with a factory baked-enamel finish.',7869,'32.33','80.84'),
('S32_1268','1980’s GM Manhattan Express','Trucks and Buses','1:32','Motor City Art Classics','This 1980’s era new look Manhattan express is still active, running from the Bronx to mid-town Manhattan. Has 35 opeining windows and working lights. Needs a battery.',5099,'53.93','96.31'),
('S32_1374','1997 BMW F650 ST','Motorcycles','1:32','Exoto Designs','Features official die-struck logos and baked enamel finish. Comes with stand.',178,'66.92','99.89'),
('S32_2206','1982 Chevy Camaro Z28','Classic Cars','1:32','Classic Metal Creations','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',9437,'39.81','79.62'),
('S32_2509','1954 Greyhound Bus','Trucks and Buses','1:32','Classic Metal Creations','Manufactured with bound diecast metal and plastic, this 1:32 scale replica of the 1954 Greyhound bus by GM is an authentic replica and features all the details of the original including over 30 windows, two opening side doors and an opening rear door. The roof has two open vents. The front has the classic Greyhound dog and white stripe on either side.',4099,'25.92','73.04'),
('S32_3207','1950''s Chicago Surface Lines Streetcar','Trains','1:32','Gearbox Collectibles','This 1:32 scale replica is an authentic reproduction of the Chicago streetcar from the 1950s. It is a die-cast body with an all-wood interior. It features doors that open and close and two realistic figurines for the person operating the streetcar. The streetcar is on a brass base and includes a display case.',1625,'62.24','104.44'),
('S32_3522','1939-40 Ford Pickup Express','Trucks and Buses','1:32','Motor City Art Classics','This 1939-40 Ford Pickup Express is a great replica of the original. It features an authentic Ford logo on the front and back of the car. It has opening doors and rubber tires. The car is painted red and has chrome grill and bumpers. The wheels are chrome and the interior is grey. This car is a very detailed replica, and it is a must-have for all car lovers.',8856,'83.58','125.75'),
('S32_4289','1941 Graham Paige Custom','Vintage Cars','1:32','Classic Metal Creations','This 1:32 scale replica of the 1941 Graham Paige Custom is a stunning model. This car has been meticulously re-created with attention to every detail of the original. It has working steering and suspension, and the doors and hood open to reveal a highly detailed interior and engine. The car is painted black and has a grey interior. The wheels are chrome with whitewall tires. This car is a must-have for any collector.',948,'56.88','100.86'),
('S50_1341','1930 Bugatti Type 35A','Vintage Cars','1:50','Motor City Art Classics','This 1:50 scale replica of the 1930 Bugatti Type 35A is a stunning model. This car has been meticulously re-created with attention to every detail of the original. It has working steering and suspension, and the doors and hood open to reveal a highly detailed interior and engine. The car is painted black and has a grey interior. The wheels are chrome with whitewall tires. This car is a must-have for any collector.',5027,'87.05','116.07');

/* Inserting data into offices */
insert into offices(officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory) values
('1','San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA'),
('2','Boston','+1 215 837 0825','1550 Court Street','Suite 100','MA','USA','02116','NA'),
('3','NYC','+1 212 555 3000','524 East 11th Street','Apt. 3B','NY','USA','10009','NA'),
('4','Paris','+33 1 40 34 83 20','43 Rue de la Perriere','','','France','75001','EMEA'),
('5','Tokyo','+81 33 224 5000','25-23-3-300 Roppongi','Minato-ku','Tokyo','Japan','106-0032','Japan'),
('6','Sydney','+61 2 9264 2451','5-1175 Bulevard','','NSW','Australia','2000','APAC'),
('7','London','+44 20 7266 9411','2401 North Main Street','Suite 200','','UK','EC2V 7DB','EMEA');

/* Inserting data into employees */
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Sales'),
(1088,'Patterson','William','x4864','wpatterson@classicmodelcars.com','6',1076,'Sales Manager (APAC)'),
(1102,'Bondur','Gerard','x5408','gbondur@classicmodelcars.com','4',1076,'Sale Manager (EMEA)'),
(1143,'Bow','Anthony','x5428','abow@classicmodelcars.com','1',1076,'Sales Manager (NA)'),
(1165,'Patterson','Steve','x4611','spatterson@classicmodelcars.com','2',1143,'Sales Rep'),
(1166,'Thompson','Leslie','x4074','lthompson@classicmodelcars.com','2',1143,'Sales Rep'),
(1188,'Arnold','Mary','x4852','marnold@classicmodelcars.com','3',1143,'Sales Rep'),
(1216,'Nishi','Keiko','x4354','knishi@classicmodelcars.com','5',1088,'Sales Rep'),
(1286,'Kato','Akira','x2184','akato@classicmodelcars.com','5',1088,'Sales Rep'),
(1337,'Mori','Kazu','x5573','kmori@classicmodelcars.com','5',1088,'Sales Rep'),
(1341,'Tseng','Fook','x2248','ftseng@classicmodelcars.com','6',1088,'Sales Rep'),
(1370,'Hernandez','Julie','x5487','jhernandez@classicmodelcars.com','4',1102,'Sales Rep'),
(1401,'Freyre','Diego','x2273','dfreyre@classicmodelcars.com','4',1102,'Sales Rep'),
(1501,'Bott','Larry','x2311','lbott@classicmodelcars.com','7',1102,'Sales Rep'),
(1504,'Jones','Barry','x1201','bjones@classicmodelcars.com','7',1102,'Sales Rep'),
(1611,'Hill','Andy','x2411','ahill@classicmodelcars.com','2',1143,'Sales Rep'),
(1612,'Lewis','Tom','x9099','tlewis@classicmodelcars.com','1',1143,'Sales Rep'),
(1619,'King','Peter','x5011','pking@classicmodelcars.com','1',1143,'Sales Rep');

/* Inserting data into customers */
insert into customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) values
(103,'Atelier graphique','Schmitt','Carine ','40.32.2555','54, rue Royale','','Nantes',NULL,'44000','France',1370,'21000.00'),
(112,'Signal Gift Stores','King','Jean','+65 221 1234','8489 Strong St.','','Singapore',NULL,'07954','Singapore',1216,'71800.00'),
(114,'Australian Collectors, Co.','Ferguson','Peter','02 9617 8452','636 St Kilda Road','','Melbourne','Victoria','3004','Australia',1088,'117300.00'),
(119,'La Rochelle Gifts','Labrune','Janine','40.67.8555','67, avenue de la Grande Armée','','Paris',NULL,'75016','France',1370,'92300.00'),
(121,'Baane Mini Imports','Bergulfsen','Hans','07-98 90 28','Erling Skakkes gate 78','','Stavern',NULL,'4006','Norway',1401,'81700.00'),
(124,'Mini Gifts Distributors Ltd.','Nelson','Susan','(415) 555-1450','5677 Strong St.','','San Rafael','CA','97562','USA',1612,'210500.00'),
(125,'Havel & Zbyszek Co.','Zbyszek','Jan','(05) 555-5555','123 Main Street','','Warszawa',NULL,'00-950','Poland',1401,'102700.00'),
(128,'Blauer See Delikatessen','Keitel','Roland','+49 69 987979','Forsterstr. 57','','Frankfurt',NULL,'60594','Germany',1504,'21000.00'),
(129,'Mini Wheels Co.','Finn','Chris','650-555-5555','123 Main St.','','San Francisco','CA','94080','USA',1165,'64000.00'),
(131,'Land of Toys Inc.','Lee','Kwai','2125557818','897 N 2nd Ave.','','New York','NY','10022','USA',1166,'114200.00'),
(141,'Euro+ Shopping Channel','Freyre','Diego','+34 91 5559444','C/ Moralzarzal, 86','','Madrid',NULL,'28034','Spain',1102,'50700.00'),
(144,'Volvo Diesel GmbH','Reine','Axel','089-601-5241','Magdalenenstraße 2','','Berlin',NULL,'10178','Germany',1504,'51700.00'),
(145,'Danish Home & Garden Sp.','Bjorn','Jens','+45 88 88 88 88','Lyngbyvej 5','','Copenhagen',NULL,'1100','Denmark',1401,'105800.00'),
(146,'L'Epée, S.A.','De la Cruz','Jean','+33 1 40 34 83 20','14, rue de la Pomme','','Toulouse',NULL,'31000','France',1370,'75600.00'),
(148,'Dragon Souveniers, Ltd.','Chang','Chi','+86 21 8765 1234','5489-A Tsing Yi St.','','Shanghai',NULL,'200000','China',1216,'103000.00'),
(151,'Gift Ideas Co.','Vance','Julie','6175558555','2870 Washington St','Suite 180','Boston','MA','02116','USA',1165,'109500.00'),
(157,'Diecast Classics Inc.','Jennings','Kim','215-555-1555','7635 N. Main St.','','Philadelphia','PA','19111','USA',1166,'100000.00'),
(161,'Technics Stores Inc.','Thompson','Leslie','4085551386','94080 N. Winchester Dr.','','San Jose','CA','95122','USA',1611,'84200.00'),
(167,'Asian Shopping Network, Co.','Tsung','George','+852 22 22 22 22','666 Quai des Indes','','Kowloon',NULL,'78000','Hong Kong',1088,'56600.00'),
(172,'Australian Collectors, Co.','Lui','Kwai','02 9617 8452','636 St Kilda Road','','Melbourne','Victoria','3004','Australia',1088,'117300.00');

/* Inserting data into payments */
insert into payments(customerNumber,checkNumber,paymentDate,amount) values
(103,'HQ336336','2004-10-19','6066.78'),
(103,'OM314933','2004-12-09','6527.18'),
(112,'AD336336','2004-10-19','8744.13'),
(112,'HQ336337','2004-12-19','8012.33'),
(114,'JM551122','2004-11-20','14571.42'),
(114,'NB336338','2004-12-25','14234.33'),
(119,'AD336338','2004-11-19','2888.13'),
(119,'AD336339','2004-12-19','2888.13'),
(121,'DB336339','2004-12-09','3044.80'),
(121,'DB336340','2004-12-29','3044.80'),
(124,'AD336340','2004-12-19','5020.15'),
(124,'KM336340','2004-12-29','5020.15'),
(125,'AD336341','2004-12-29','6044.33'),
(128,'DB336342','2005-01-09','4021.56'),
(129,'DB336343','2005-01-19','3902.77'),
(131,'DB336344','2005-01-29','4100.99'),
(141,'DB336345','2005-02-09','4200.88'),
(144,'DB336346','2005-02-19','4300.77'),
(145,'DB336347','2005-02-29','4400.66'),
(146,'DB336348','2005-03-09','4500.55'),
(148,'DB336349','2005-03-19','4600.44'),
(151,'DB336350','2005-03-29','4700.33'),
(157,'DB336351','2005-04-09','4800.22'),
(161,'DB336352','2005-04-19','4900.11'),
(167,'DB336353','2005-04-29','5000.00'),
(172,'DB336354','2005-05-09','5100.00');

/* Inserting data into orders */
insert into orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber) values
(10100,'2003-01-06','2003-01-13','2003-01-10','Shipped',NULL,103),
(10101,'2003-01-09','2003-01-18','2003-01-11','Shipped',NULL,112),
(10102,'2003-01-10','2003-01-18','2003-01-14','Shipped',NULL,114),
(10103,'2003-01-29','2003-02-07','2003-02-02','Shipped','Marketing agreed to pay for this order',121),
(10104,'2003-01-31','2003-02-08','2003-02-05','Shipped',NULL,125),
(10105,'2003-02-11','2003-02-21','2003-02-14','Shipped',NULL,128),
(10106,'2003-02-17','2003-02-27','2003-02-20','Shipped',NULL,129),
(10107,'2003-02-24','2003-03-03','2003-02-26','Shipped',NULL,131),
(10108,'2003-03-03','2003-03-12','2003-03-07','Shipped',NULL,141),
(10109,'2003-03-10','2003-03-19','2003-03-12','Shipped',NULL,144),
(10110,'2003-03-18','2003-03-26','2003-03-21','Shipped',NULL,145),
(10111,'2003-03-25','2003-04-03','2003-03-28','Shipped',NULL,146),
(10112,'2003-04-01','2003-04-10','2003-04-04','Shipped',NULL,148),
(10113,'2003-04-08','2003-04-17','2003-04-11','Shipped',NULL,151),
(10114,'2003-04-15','2003-04-24','2003-04-18','Shipped',NULL,157),
(10115,'2003-04-22','2003-05-02','2003-04-25','Shipped',NULL,161),
(10116,'2003-04-29','2003-05-08','2003-05-02','Shipped',NULL,167),
(10117,'2003-05-06','2003-05-16','2003-05-09','Shipped',NULL,172);

/* Inserting data into orderdetails */
insert into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) values
(10100,'S18_1749',30,'136.00',1),
(10100,'S18_2248',50,'49.12',2),
(10100,'S18_4409',25,'73.65',3),
(10101,'S10_4698',25,'174.29',1),
(10101,'S18_2625',40,'54.10',2),
(10102,'S12_1099',30,'155.65',1),
(10102,'S12_3148',25,'120.84',2),
(10103,'S18_1367',45,'48.00',1),
(10103,'S24_1937',20,'30.00',2),
(10104,'S18_3232',40,'140.00',1),
(10104,'S24_2022',25,'40.00',2),
(10105,'S10_4962',35,'125.00',1),
(10105,'S24_3420',30,'55.00',2),
(10106,'S18_3856',20,'90.00',1),
(10106,'S24_4258',25,'80.00',2),
(10107,'S12_3990',15,'70.00',1),
(10107,'S18_4721',30,'130.00',2),
(10108,'S18_1589',50,'110.00',1),
(10108,'S24_2887',20,'100.00',2),
(10109,'S10_1949',40,'190.00',1),
(10109,'S12_4473',25,'105.00',2),
(10110,'S18_1342',30,'90.00',1),
(10110,'S18_3140',25,'120.00',2),
(10111,'S24_2300',20,'115.00',1),
(10111,'S32_1268',40,'85.00',2),
(10112,'S12_1108',30,'190.00',1),
(10112,'S18_1984',25,'130.00',2),
(10113,'S18_3278',35,'75.00',1),
(10113,'S24_1046',20,'65.00',2),
(10114,'S12_3891',25,'160.00',1),
(10114,'S32_2206',30,'70.00',2),
(10115,'S10_2016',40,'105.00',1),
(10115,'S24_2766',25,'85.00',2),
(10116,'S18_4668',30,'45.00',1),
(10116,'S32_3522',20,'115.00',2),
(10117,'S12_1666',35,'120.00',1),
(10117,'S24_1578',20,'100.00',2);


SELECT checkNumber, paymentDate, amount
FROM payments;

SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'In Process'
ORDER BY orderDate DESC;

SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;

SELECT *
FROM offices;

SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC
LIMIT 5;


