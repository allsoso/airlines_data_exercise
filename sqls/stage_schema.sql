
CREATE TABLE stage.aircrafts_data (
	aircraft_code text NULL,
	model jsonb NULL,
	"range" int8 NULL
);

CREATE TABLE stage.airports_data (
	airport_code text NULL,
	airport_name jsonb NULL,
	city jsonb NULL,
	coordinates point NULL,
	timezone text NULL
);

CREATE TABLE stage.boarding_passes (
	ticket_no text NULL,
	flight_id int8 NULL,
	boarding_no int8 NULL,
	seat_no bpchar(4) NULL
);

CREATE TABLE stage.bookings (
	book_ref text NULL,
	book_date timestamptz NULL,
	total_amount numeric(10, 2) NULL
);

CREATE TABLE stage.flights (
	flight_id int8 NULL,
	flight_no text NULL,
	scheduled_departure timestamptz NULL,
	scheduled_arrival timestamptz NULL,
	departure_airport text NULL,
	arrival_airport text NULL,
	status bpchar(20) NULL,
	aircraft_code text NULL,
	actual_departure timestamptz NULL,
	actual_arrival timestamptz NULL
);

CREATE TABLE stage.seats (
	aircraft_code text NULL,
	seat_no bpchar(4) NULL,
	fare_conditions bpchar(10) NULL
);

CREATE TABLE stage.ticket_flights (
	ticket_no text NULL,
	flight_id int8 NULL,
	fare_conditions bpchar(10) NULL,
	amount numeric(10, 2) NULL
);

CREATE TABLE stage.tickets (
	ticket_no text NULL,
	book_ref text NULL,
	passenger_id bpchar(20) NULL
);

ALTER TABLE stage.aircrafts_data OWNER TO postgres;
ALTER TABLE stage.airports_data OWNER TO postgres;
ALTER TABLE stage.boarding_passes OWNER TO postgres;
ALTER TABLE stage.bookings OWNER TO postgres;
ALTER TABLE stage.flights OWNER TO postgres;
ALTER TABLE stage.seats OWNER TO postgres;
ALTER TABLE stage.ticket_flights OWNER TO postgres;
ALTER TABLE stage.tickets OWNER TO postgres;

GRANT ALL ON TABLE stage.aircrafts_data TO postgres;
GRANT ALL ON TABLE stage.airports_data TO postgres;
GRANT ALL ON TABLE stage.boarding_passes TO postgres;
GRANT ALL ON TABLE stage.bookings TO postgres;
GRANT ALL ON TABLE stage.flights TO postgres;
GRANT ALL ON TABLE stage.seats TO postgres;
GRANT ALL ON TABLE stage.ticket_flights TO postgres;
GRANT ALL ON TABLE stage.tickets TO postgres;

GRANT ALL ON SCHEMA stage TO pg_database_owner;
GRANT USAGE ON SCHEMA stage TO public;


ALTER TABLE stage.tickets ADD CONSTRAINT pk_tickets_ticket_no PRIMARY KEY (ticket_no);
ALTER TABLE stage.aircrafts_data ADD CONSTRAINT aircrafts_data_pk PRIMARY KEY (aircraft_code);
ALTER TABLE stage.airports_data ADD CONSTRAINT airports_data_pk PRIMARY KEY (airport_code);
ALTER TABLE stage.bookings ADD CONSTRAINT bookings_pk PRIMARY KEY (book_ref);
ALTER TABLE stage.flights ADD CONSTRAINT flights_pk PRIMARY KEY (flight_id);
