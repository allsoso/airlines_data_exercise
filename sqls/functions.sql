CREATE FUNCTION percentual_ocupacao_voo(flight_id_input INT)
RETURNS NUMERIC AS $$
DECLARE
    total_seats INT;
    boarded_passengers INT;
BEGIN
    SELECT COUNT(*) INTO total_seats
    FROM seats s
    JOIN flights f ON s.aircraft_code = f.aircraft_code
    WHERE f.flight_id = flight_id_input;
    
    SELECT COUNT(*) INTO boarded_passengers
    FROM boarding_passes bp
    WHERE bp.flight_id = flight_id_input;
    
    IF total_seats = 0 THEN
        RETURN 0;
    ELSE
        RETURN ROUND((boarded_passengers * 100.0) / total_seats, 2);
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION receita_total_por_booking(book_ref_input TEXT)
RETURNS NUMERIC AS $$
DECLARE
    receita_total NUMERIC;
BEGIN
    SELECT SUM(tf.amount) INTO receita_total
    FROM ticket_flights tf
    JOIN tickets t ON tf.ticket_no = t.ticket_no
    WHERE t.book_ref = book_ref_input;
    
    RETURN COALESCE(receita_total, 0);
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION qtd_assentos_disponiveis(flight_id_input INT)
RETURNS INT AS $$
DECLARE
    assentos_totais INT;
    passageiros INT;
BEGIN
    SELECT COUNT(*) INTO assentos_totais
    FROM seats s
    JOIN flights f ON s.aircraft_code = f.aircraft_code
    WHERE f.flight_id = flight_id_input;
    
    SELECT COUNT(*) INTO passageiros
    FROM boarding_passes bp
    WHERE bp.flight_id = flight_id_input;
    
    RETURN assentos_totais - passageiros;
END;
$$ LANGUAGE plpgsql;



--select percentual_ocupacao_voo(5432)
--select percentual_ocupacao_voo(20210)
--select receita_total_por_booking('003096')
--select qtd_assentos_disponiveis(24602)
