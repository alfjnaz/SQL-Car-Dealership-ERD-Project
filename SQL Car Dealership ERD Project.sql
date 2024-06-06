-- Creating the customer table with customer details
CREATE TABLE customer_alfred (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  phone_number VARCHAR(15)
);

-- Creating the salesperson table with salesperson details
CREATE TABLE salesperson_alfred (
  salesperson_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  phone_number VARCHAR(15)
);

-- Creating the car table with car details
CREATE TABLE car_alfred (
  car_id SERIAL PRIMARY KEY,
  vin VARCHAR(100),
  make_year INTEGER,
  model VARCHAR(100)
);

-- Creating the mechanic table with mechanic details
CREATE TABLE mechanic_alfred (
  mechanic_no SERIAL PRIMARY KEY,
  first_name VARCHAR(100)
);

-- Creating the part table with part details
CREATE TABLE part_alfred (
  part_id SERIAL PRIMARY KEY,
  part_number VARCHAR(150),
  purchase_price NUMERIC(8,2)
);

-- Creating the invoice table with sale details and foreign keys to other tables
CREATE TABLE invoice_alfred (
  sale_no SERIAL PRIMARY KEY,
  sale_date TIME(2),
  amount NUMERIC(5,2),
  staff_id INTEGER REFERENCES salesperson_alfred(salesperson_id),
  customer_id INTEGER REFERENCES customer_alfred(customer_id),
  car_id INTEGER REFERENCES car_alfred(car_id)
);

-- Creating the service history table with service details and a foreign key to the car table
CREATE TABLE service_history_alfred (
  serial_no SERIAL PRIMARY KEY,
  repair VARCHAR(150),
  car_id INTEGER REFERENCES car_alfred(car_id)
);

-- Creating the service ticket table with service ticket details and foreign keys to other tables
CREATE TABLE service_ticket_alfred (
  service_ticket_id SERIAL PRIMARY KEY,
  service_date DATE,
  customer_id INTEGER REFERENCES customer_alfred(customer_id),
  car_serial_number INTEGER REFERENCES car_alfred(car_id)
);

-- Inserting initial data into the customer table
INSERT INTO customer_alfred (first_name, phone_number) VALUES ('John', '123-456-7890');
INSERT INTO customer_alfred (first_name, phone_number) VALUES ('Jane', '098-765-4321');

-- Inserting initial data into the salesperson table
INSERT INTO salesperson_alfred (first_name, phone_number) VALUES ('Alice', '555-1234');
INSERT INTO salesperson_alfred (first_name, phone_number) VALUES ('Bob', '555-5678');



-- Defining a stored function to insert data into the salesperson table
CREATE OR REPLACE FUNCTION insert_salesperson(firstname VARCHAR, phonenumber VARCHAR) RETURNS VOID AS $$
BEGIN
  INSERT INTO salesperson_alfred (first_name, phone_number) VALUES (firstname, phonenumber);
END;
$$ LANGUAGE plpgsql;

-- Defining a stored function to insert data into the customer table
CREATE OR REPLACE FUNCTION insert_customer(firstname VARCHAR, phonenumber VARCHAR) RETURNS VOID AS $$
BEGIN
  INSERT INTO customer_alfred (first_name, phone_number) VALUES (firstname, phonenumber);
END;
$$ LANGUAGE plpgsql;

-- Using the stored functions to insert additional records into the salesperson and customer tables
SELECT insert_salesperson('Charlie', '555-9012');
SELECT insert_salesperson('Diana', '555-3456');
SELECT insert_customer('Ethan', '555-7890');
SELECT insert_customer('Fiona', '555-6543');

-- Just checking to make sure everything is in properly

select * from salesperson_alfred