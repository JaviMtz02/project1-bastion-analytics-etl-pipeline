
CREATE DATABASE shipments;
GO

use shipments;

CREATE TABLE weight_units (
	weight_unit_id INT PRIMARY KEY,
	weight_unit VARCHAR(100)
);

CREATE TABLE arrival_date (
	arrival_date_id INT PRIMARY KEY,
	arrival_date DATE
);

CREATE TABLE estimated_arrival_date (
	estimated_arrival_id INT PRIMARY KEY,
	estimated_arrival_date DATE
);

CREATE TABLE manifest_quantities (
	manifest_quantity_id INT PRIMARY KEY,
	manifest_quantity INT
);

CREATE TABLE port_of_unlading (
	port_unlading_id INT PRIMARY KEY,
	port_of_unlading NVARCHAR(500)
);

CREATE TABLE port_of_lading (
	port_lading_id INT PRIMARY KEY,
	port_of_lading NVARCHAR(500)
);

CREATE TABLE [weight] (
	weight_id INT PRIMARY KEY,
	[weight] BIGINT
);


CREATE TABLE shipments (
	identifier BIGINT PRIMARY KEY,

	port_lading_id INT,
	port_unlading_id INT,
	arrival_date_id INT,
	estimated_arrival_id INT,
	weight_id INT,
	manifest_quantity_id INT,
	weight_unit_id INT,

	FOREIGN KEY (port_lading_id) REFERENCES port_of_lading(port_lading_id),
	FOREIGN KEY (port_unlading_id) REFERENCES port_of_unlading(port_unlading_id),
	FOREIGN KEY (arrival_date_id) REFERENCES arrival_date(arrival_date_id),
	FOREIGN KEY (estimated_arrival_id) REFERENCES estimated_arrival_date(estimated_arrival_id),
	FOREIGN KEY (weight_id) REFERENCES [weight](weight_id),
	FOREIGN KEY (manifest_quantity_id) REFERENCES manifest_quantities(manifest_quantity_id),
	FOREIGN KEY (weight_unit_id) REFERENCES weight_units(weight_unit_id)
);
