DROP TRIGGER IF EXISTS trg_replicate_aircrafts_data_to_stage ON public.aircrafts_data;
DROP TRIGGER IF EXISTS trg_replicate_airports_data_to_stage ON public.airports_data;
DROP TRIGGER IF EXISTS trg_replicate_boarding_passes_to_stage ON public.boarding_passes;
DROP TRIGGER IF EXISTS trg_replicate_bookings_to_stage ON public.bookings;
DROP TRIGGER IF EXISTS trg_replicate_flights_to_stage ON public.flights;
DROP TRIGGER IF EXISTS trg_replicate_seats_to_stage ON public.seats;
DROP TRIGGER IF EXISTS trg_replicate_ticket_flights_to_stage ON public.ticket_flights;
DROP TRIGGER IF EXISTS trg_replicate_tickets_to_stage ON public.tickets;

DROP FUNCTION IF EXISTS replicate_aircrafts_data_to_stage;
DROP FUNCTION IF EXISTS replicate_airports_data_to_stage;
DROP FUNCTION IF EXISTS replicate_boarding_passes_to_stage;
DROP FUNCTION IF EXISTS replicate_bookings_to_stage;
DROP FUNCTION IF EXISTS replicate_flights_to_stage;
DROP FUNCTION IF EXISTS replicate_seats_to_stage;
DROP FUNCTION IF EXISTS replicate_ticket_flights_to_stage;
DROP FUNCTION IF EXISTS replicate_tickets_to_stage;

CREATE OR REPLACE FUNCTION replicate_aircrafts_data_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.aircrafts_data SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_aircrafts_data_to_stage
AFTER INSERT OR UPDATE ON public.aircrafts_data
FOR EACH ROW EXECUTE FUNCTION replicate_aircrafts_data_to_stage();


CREATE OR REPLACE FUNCTION replicate_airports_data_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.airports_data SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_airports_data_to_stage
AFTER INSERT OR UPDATE ON public.airports_data
FOR EACH ROW EXECUTE FUNCTION replicate_airports_data_to_stage();


CREATE OR REPLACE FUNCTION replicate_boarding_passes_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.boarding_passes SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_boarding_passes_to_stage
AFTER INSERT OR UPDATE ON public.boarding_passes
FOR EACH ROW EXECUTE FUNCTION replicate_boarding_passes_to_stage();


CREATE OR REPLACE FUNCTION replicate_bookings_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.bookings SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_bookings_to_stage
AFTER INSERT OR UPDATE ON public.bookings
FOR EACH ROW EXECUTE FUNCTION replicate_bookings_to_stage();


CREATE OR REPLACE FUNCTION replicate_flights_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.flights SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_flights_to_stage
AFTER INSERT OR UPDATE ON public.flights
FOR EACH ROW EXECUTE FUNCTION replicate_flights_to_stage();


CREATE OR REPLACE FUNCTION replicate_seats_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.seats SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_seats_to_stage
AFTER INSERT OR UPDATE ON public.seats
FOR EACH ROW EXECUTE FUNCTION replicate_seats_to_stage();


CREATE OR REPLACE FUNCTION replicate_ticket_flights_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.ticket_flights SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_ticket_flights_to_stage
AFTER INSERT OR UPDATE ON public.ticket_flights
FOR EACH ROW EXECUTE FUNCTION replicate_ticket_flights_to_stage();


CREATE OR REPLACE FUNCTION replicate_tickets_to_stage()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stage.tickets SELECT NEW.*;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_replicate_tickets_to_stage
AFTER INSERT OR UPDATE ON public.tickets
FOR EACH ROW EXECUTE FUNCTION replicate_tickets_to_stage();