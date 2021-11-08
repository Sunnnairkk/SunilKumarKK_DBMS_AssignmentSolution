/*Assignment 4*/

CREATE DATABASE TRAVELONTHEGO;

USE TRAVELONTHEGO;

/* PASSENGER TABLE */

CREATE TABLE IF NOT EXISTS passenger(
Passenger_name varchar(50),
Category varchar(20),
Gender varchar(5),
Boarding_City varchar(30),
Destination_City varchar(30),
Distance int,
Bus_Type varchar(20) );

/* PRICE TABLE */

CREATE TABLE IF NOT EXISTS price (
Bus_Type varchar(20),
Distance int,
Price int );

/* PASSENGER RECORDS */

INSERT INTO passenger VALUES("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
INSERT INTO passenger VALUES("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
INSERT INTO passenger VALUES("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
INSERT INTO passenger VALUES("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
INSERT INTO passenger VALUES("Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper");
INSERT INTO passenger VALUES("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
INSERT INTO passenger VALUES("Hemant", "Non-AC", "M", "panaji", "Mumbai", 700, "Sleeper");
INSERT INTO passenger VALUES("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
INSERT INTO passenger VALUES("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");

/* PRICE RECORDS */

INSERT INTO price VALUES("Sleeper", 350, 770);
INSERT INTO price VALUES("Sleeper", 500, 1100);
INSERT INTO price VALUES("Sleeper", 600, 1320);
INSERT INTO price VALUES("Sleeper", 700, 1540);
INSERT INTO price VALUES("Sleeper", 1000, 2200);
INSERT INTO price VALUES("Sleeper", 1200, 2640);
INSERT INTO price VALUES("Sleeper", 350, 434);
INSERT INTO price VALUES("Sitting", 500, 620);
INSERT INTO price VALUES("Sitting", 500, 620);
INSERT INTO price VALUES("Sitting", 600, 744);
INSERT INTO price VALUES("Sitting", 700, 868);
INSERT INTO price VALUES("Sitting", 1000, 1240);
INSERT INTO price VALUES("Sitting", 1200, 1488);
INSERT INTO price VALUES("Sitting", 1500, 1860);


/*3) How many females and how many male passengers travelled for a minimum distance of
600 KM s? */

SELECT CASE WHEN GENDER = "M" THEN "MALES" WHEN GENDER = "F" THEN "FEMALES" END AS GENDER,
COUNT(*) AS PASSENGERS_TRAVELLED_MIN_600 FROM PASSENGER WHERE DISTANCE >=600  GROUP BY GENDER; 

/*4) Find the minimum ticket price for Sleeper Bus. */

SELECT MIN(PRICE) AS MIN_SLEEPER_BUS_TICKET_PRICE FROM PRICE WHERE BUS_TYPE = "Sleeper";

/*5) Select passenger names whose names start with character 'S' */

SELECT PASSENGER_NAME AS PASSENGER_NAME_STARTS_WITH_S FROM PASSENGER WHERE PASSENGER_NAME LIKE ("S%");

/*6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */   

SELECT distinct P.PASSENGER_NAME, P.BOARDING_CITY, P.DESTINATION_CITY, P.BUS_TYPE, R.PRICE FROM PASSENGER P, PRICE R 
WHERE P.BUS_TYPE = R.BUS_TYPE AND P.DISTANCE = R.DISTANCE;

/*7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s */

SELECT P.PASSENGER_NAME, R.PRICE FROM PASSENGER P, PRICE R WHERE P.BUS_TYPE = R.BUS_TYPE 
AND P.DISTANCE = R.DISTANCE AND P.DISTANCE >= 1000 AND P.BUS_TYPE = "Sitting";

/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji? 
- Question in unclear : Whether Bengaluru and Bangalore should we treat as same? Panaji to Bengaluru price and return price are same?  */

SELECT P.BUS_TYPE, R.PRICE AS PALLAVI_BANGALORE_PANAJI_PRICE FROM PASSENGER P, PRICE R 
WHERE P.BOARDING_CITY = "Panaji" AND P.DESTINATION_CITY = "Bengaluru"
AND P.BUS_TYPE = R.BUS_TYPE AND P.DISTANCE = R.DISTANCE;

/*9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */

SELECT distinct DISTANCE FROM PASSENGER ORDER BY DISTANCE DESC;

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables */

SELECT C.PASSENGER_NAME, C.PASSENGER_TOTAL_DISTANCE * 100 / C.TOTAL AS PASSENGER_PERCENTAGE FROM (
SELECT A.PASSENGER_NAME, SUM(A.DISTANCE) AS PASSENGER_TOTAL_DISTANCE,  (SELECT SUM(B.DISTANCE) FROM PASSENGER B) AS TOTAL FROM PASSENGER A 
GROUP BY A.PASSENGER_NAME, TOTAL) C;


/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

SELECT DISTANCE, PRICE, CASE WHEN PRICE > 1000 THEN "Expensive"
WHEN PRICE > 500 THEN "Average Cost"
ELSE "Cheap" END AS PRICE_TYPE FROM PRICE;

