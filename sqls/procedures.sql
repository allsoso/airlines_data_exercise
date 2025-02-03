CREATE PROCEDURE inserir_voo(
    flight_no TEXT,
    scheduled_departure TIMESTAMPTZ,
    scheduled_arrival TIMESTAMPTZ,
    departure_airport TEXT,
    arrival_airport TEXT,
    aircraft_code TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO flights (flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, aircraft_code)
    VALUES (flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, aircraft_code);
END;
$$;

CREATE PROCEDURE cancelar_booking(book_ref_input TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM tickets WHERE book_ref = book_ref_input;
    DELETE FROM bookings WHERE book_ref = book_ref_input;
END;
$$;

CREATE OR REPLACE PROCEDURE check_scheduled_flights()
LANGUAGE plpgsql AS $$
DECLARE
    flight_record RECORD;
BEGIN
    FOR flight_record IN
        SELECT flight_id, flight_no, scheduled_departure
        FROM flights
        WHERE status = 'Scheduled'
        AND actual_departure IS NULL
        AND scheduled_departure < NOW()
    LOOP
        RAISE NOTICE 'Flight ID: %, Flight No: %, Scheduled Departure: %', 
            flight_record.flight_id, 
            flight_record.flight_no, 
            flight_record.scheduled_departure;
    END LOOP;
END;
$$;


/*
CALL inserir_voo(
    'FL1234', 
    '2025-02-10 15:00:00+00', 
    '2025-02-10 17:00:00+00', 
    'PEE', 
    'GDX', 
    'SU9'
);
*/

--call cancelar_booking('000352')
