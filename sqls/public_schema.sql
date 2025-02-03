

ALTER TABLE public.tickets ADD CONSTRAINT pk_tickets_ticket_no PRIMARY KEY (ticket_no);
ALTER TABLE public.aircrafts_data ADD CONSTRAINT aircrafts_data_pk PRIMARY KEY (aircraft_code);
ALTER TABLE public.airports_data ADD CONSTRAINT airports_data_pk PRIMARY KEY (airport_code);
ALTER TABLE public.bookings ADD CONSTRAINT bookings_pk PRIMARY KEY (book_ref);
ALTER TABLE public.flights ADD CONSTRAINT flights_pk PRIMARY KEY (flight_id);


ALTER TABLE public.boarding_passes
ADD CONSTRAINT fk_boarding_passes_ticket_no
    FOREIGN KEY (ticket_no) REFERENCES public.tickets (ticket_no),
ADD CONSTRAINT fk_boarding_passes_flight_id
    FOREIGN KEY (flight_id) REFERENCES public.flights (flight_id);


ALTER TABLE public.seats
ADD CONSTRAINT fk_seats_aircraft_code
    FOREIGN KEY (aircraft_code) REFERENCES public.aircrafts_data (aircraft_code);


ALTER TABLE public.ticket_flights 
ADD CONSTRAINT fk_ticket_flights_ticket_no
    FOREIGN KEY (ticket_no) REFERENCES public.tickets (ticket_no),
ADD CONSTRAINT fk_ticket_flights_flight_id
    FOREIGN KEY (flight_id) REFERENCES public.flights (flight_id);


ALTER TABLE public.tickets
ADD CONSTRAINT fk_tickets_book_ref
    FOREIGN KEY (book_ref) REFERENCES public.bookings (book_ref);


ALTER TABLE public.flights
ADD CONSTRAINT fk_flights_departure_airport
    FOREIGN KEY (departure_airport) REFERENCES public.airports_data (airport_code),
ADD CONSTRAINT fk_flights_arrival_airport
    FOREIGN KEY (arrival_airport) REFERENCES public.airports_data (airport_code),
ADD CONSTRAINT fk_flights_aircraft_code
    FOREIGN KEY (aircraft_code) REFERENCES public.aircrafts_data (aircraft_code);


CREATE SEQUENCE IF NOT EXISTS flights_flight_id_seq START 1;
ALTER TABLE public.flights ALTER COLUMN flight_id SET DEFAULT nextval('flights_flight_id_seq');
SELECT setval('flights_flight_id_seq', COALESCE((SELECT MAX(flight_id)+1 FROM public.flights), 1), false);