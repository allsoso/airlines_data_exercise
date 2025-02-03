CREATE OR REPLACE FUNCTION zerar_valor_cancelamento_voo()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE public.bookings
    SET total_amount = 0
    WHERE book_ref = (
        SELECT book_ref 
        FROM public.tickets 
        WHERE ticket_no IN (
            SELECT ticket_no 
            FROM public.ticket_flights 
            WHERE flight_id = NEW.flight_id
        )
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER flight_status_update_trigger
AFTER UPDATE OF status ON public.flights
FOR EACH ROW
EXECUTE FUNCTION zerar_valor_cancelamento_voo();


CREATE OR REPLACE FUNCTION atualizar_booking_total_com_alteracao_ticket()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE bookings
    SET total_amount = (
        SELECT SUM(tf.amount) 
        FROM ticket_flights tf
        WHERE tf.ticket_no IN (SELECT ticket_no FROM tickets WHERE book_ref = NEW.book_ref)
    )
    WHERE book_ref = NEW.book_ref;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_booking_amount_trigger
AFTER UPDATE ON ticket_flights
FOR EACH ROW
EXECUTE FUNCTION atualizar_booking_total_com_alteracao_ticket();


CREATE OR REPLACE FUNCTION atualizar_booking_total_amount_novo_ticket()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE bookings
    SET total_amount = (
        SELECT SUM(amount) 
        FROM ticket_flights 
        WHERE ticket_no = NEW.ticket_no
    )
    WHERE book_ref = NEW.book_ref;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_booking_total_amount_trigger
AFTER INSERT ON tickets
FOR EACH ROW
EXECUTE FUNCTION atualizar_booking_total_amount_novo_ticket();
