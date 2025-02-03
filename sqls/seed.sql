INSERT INTO stage.airports_data (airport_code, airport_name, city, coordinates, timezone) VALUES
('JFK', '{"en": "John F. Kennedy International Airport"}', '{"en": "New York"}', POINT(-73.7781, 40.6413), 'America/New_York'),
('LAX', '{"en": "Los Angeles International Airport"}', '{"en": "Los Angeles"}', POINT(-118.4085, 33.9416), 'America/Los_Angeles');

INSERT INTO stage.aircrafts_data (aircraft_code, model, "range") VALUES
('A320', '{"en": "Airbus A320"}', 6150),
('B737', '{"en": "Boeing 737"}', 5465),
('E190', '{"en": "Embraer 190"}', 4537);

INSERT INTO stage.seats (aircraft_code, seat_no, fare_conditions) VALUES
('A320', '1A', 'Business'),
('A320', '2B', 'Economy'),
('B737', '3C', 'Economy'),
('E190', '4D', 'Economy');

INSERT INTO stage.bookings (book_ref, book_date, total_amount) VALUES
('BR001', '2025-02-01 10:00:00+00', 500.00),
('BR002', '2025-02-02 12:30:00+00', 320.00);

INSERT INTO stage.tickets (ticket_no, book_ref, passenger_id) VALUES
('T001', 'BR001', 'PAX1234567890'),
('T002', 'BR002', 'PAX0987654321');

INSERT INTO public.flights (flight_id, flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, status, aircraft_code, actual_departure, actual_arrival) VALUES
(99991, 'AA100', '2025-02-03 08:00:00+00', '2025-02-03 12:00:00+00', 'JFK', 'LAX', 'Scheduled', 'A320', NULL, NULL),
(99992, 'UA200', '2025-02-04 09:00:00+00', '2025-02-04 13:30:00+00', 'LAX', 'JFK', 'Scheduled', 'B737', NULL, NULL);

INSERT INTO stage.ticket_flights (ticket_no, flight_id, fare_conditions, amount) VALUES
('T001', 99991, 'Business', 250.00),
('T002', 99992, 'Economy', 320.00);

INSERT INTO stage.boarding_passes (ticket_no, flight_id, boarding_no, seat_no) VALUES
('T001', 99991, 1, '1A'),
('T002', 99992, 2, '3C');
