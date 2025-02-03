DROP TABLE IF EXISTS public.dim_airport;
DROP TABLE IF EXISTS public.dim_aircraft;
DROP TABLE IF EXISTS public.dim_flights;
DROP TABLE IF EXISTS public.dim_tickets;
DROP TABLE IF EXISTS public.dim_bookings;
DROP TABLE IF EXISTS public.dim_boarding_passes;
DROP TABLE IF exists public.fact_amount_flights;
DROP TABLE IF exists stage.fact_amount_flights;


CREATE TABLE dim_airport (
    id_airport SERIAL PRIMARY KEY,
    airport_code TEXT NOT NULL,
    airport_name TEXT NOT NULL,
    city TEXT NOT NULL,
    coordinates POINT,
    timezone TEXT
);

CREATE TABLE dim_aircraft (
    id_aircraft SERIAL PRIMARY KEY,
    aircraft_code TEXT NOT NULL,
    model TEXT NOT NULL,
    range INT
);

CREATE TABLE dim_flights (
    id_flight SERIAL PRIMARY KEY,
	flight_no text NULL,
	scheduled_departure timestamptz NULL,
	scheduled_arrival timestamptz NULL,
	departure_airport text NULL,
	arrival_airport text NULL,
	status varchar NULL,
	aircraft_code text NULL,
	actual_departure timestamptz NULL,
	actual_arrival timestamptz NULL
);

CREATE TABLE dim_tickets (
    id_ticket SERIAL PRIMARY KEY,
	ticket_no text NULL,
	fare_conditions bpchar(10) NULL
);

CREATE TABLE dim_bookings (
    id_booking SERIAL PRIMARY KEY,
	book_ref text NULL,
	book_date timestamptz NULL
);

CREATE TABLE dim_boarding_passes (
    id_boarding_pass SERIAL PRIMARY KEY,
	boarding_no int8 NULL,
	seat_no bpchar(4) NULL
);

CREATE TABLE fact_amount_flights (
    id_fact SERIAL PRIMARY KEY,
    amount_ticket_value numeric(10,2) not null,
    id_flight INT NOT NULL REFERENCES dim_flights(id_flight),
    id_aircraft INT NOT NULL REFERENCES dim_aircraft(id_aircraft),
    id_departure_airport INT NOT NULL REFERENCES dim_airport(id_airport),
    id_arrival_airport INT NOT NULL REFERENCES dim_airport(id_airport),
);

CREATE TABLE stage.fact_amount_flights (
    amount_ticket_value NUMERIC(15,2) NOT NULL DEFAULT 0,
    flight_id INT NOT null primary key,
    aircraft_code VARCHAR NOT NULL,
    departure_airport_code VARCHAR NOT NULL,
    arrival_airport_code VARCHAR NOT NULL
);



ALTER TABLE dim_airport ADD CONSTRAINT unique_airport_code UNIQUE (airport_code);
ALTER TABLE dim_aircraft ADD CONSTRAINT unique_aircraft_code UNIQUE (aircraft_code);
ALTER TABLE dim_tickets ADD CONSTRAINT unique_ticket_no UNIQUE (ticket_no);
ALTER TABLE dim_bookings ADD CONSTRAINT unique_book_ref UNIQUE (book_ref, book_date);
ALTER TABLE dim_boarding_passes ADD CONSTRAINT unique_boarding_no UNIQUE (boarding_no, seat_no);
ALTER TABLE public.fact_amount_flights ADD CONSTRAINT unique_id_flight_fact UNIQUE (id_flight);
