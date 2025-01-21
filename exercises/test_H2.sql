-- QUESTION 1:
--------------
-- Create a table 'fuel_types' with the possible fuel types
-- The table contains the following information:
--  fuel_code - the primary key
--              with automatic sequence starting from 10, increasing by 5, not to be chosen by the user
--  fuel_name - this will contain the possible fuel types currently in the vehicle table
--              must be in uppercase
--              no duplicate values are allowed
--  max_octane_rating - a number between 87 and 100
--                      if no max_octane rating is provided, the value should be set to 93.

CREATE TABLE fuel_types(
    fuel_code INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY ( START WITH 10 INCREMENT BY 5),
    fuel_name VARCHAR(100) NOT NULL UNIQUE CHECK ( fuel_name=UPPER(fuel_name)),
    max_octane_rating NUMERIC(3) DEFAULT 93 CHECK ( max_octane_rating BETWEEN 87 AND 100));
-- QUESTION 2
-------------
--  Ensure that the 'fuel_types' table is populated using a command with values from the 'fuel_type' attribute in the 'vehicles' table,
--  pay attention to all existing values
--  Create a new attribute 'fuel_code' in 'vehicles' that refers to the 'fuel_types' table
--    ensure that the reference from the 'vehicles' table points to the correct code in 'fuel_types'
--    remove the current 'fuel_type' in the 'vehicles' table
--  Ensure that when a 'fuel_type' disappears, the vehicles with this fuel type also disappear automatically

ALTER TABLE fuel_types
ADD CONSTRAINT ch_fuel_types
------------
-- Question 3
-- Create a view named 'favorite_car'
-- who are the drivers of the car that was used the most for rides.
-- Display their number of rides with this vehicle.
-- Pay attention to the output of the select  * from favorite_car

/*
first_name | last_name     |  "number of rides from this driver"
-----------+----------------+---------------------------------------
Peter      | Localtelli    | has 2 rides with Renault Scenic no: 1
Takashi    | Miyamoto      | has 1 ride with Renault Scenic no: 1