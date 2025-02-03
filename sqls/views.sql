drop view media_atraso_por_aeroporto_semana
CREATE VIEW media_atraso_por_aeroporto_semana AS
SELECT
    f.departure_airport AS codigo_aeroporto,
    DATE_TRUNC('week', f.actual_departure) AS inicio_semana,
    AVG(EXTRACT(EPOCH FROM (f.actual_departure - f.scheduled_departure)) / 3600) AS media_atraso_horas
FROM
    flights f
WHERE
    f.actual_departure IS NOT NULL
    AND f.scheduled_departure IS NOT null
    and f.actual_departure > f.scheduled_departure
GROUP BY
    f.departure_airport,
    inicio_semana;

CREATE VIEW flight_occupancy AS 
SELECT  
    f.flight_id, 
    f.flight_no, 
    f.scheduled_departure AS flight_date, 
    COUNT(bp.ticket_no) AS boarded_passengers, 
    (SELECT COUNT(*) FROM seats s WHERE s.aircraft_code = f.aircraft_code) AS total_seats, 
    ROUND( 
        (COUNT(bp.ticket_no) * 100.0) / NULLIF( 
            (SELECT COUNT(*) FROM seats s WHERE s.aircraft_code = f.aircraft_code),  0),2) AS occupancy_percentage 
FROM flights f 
LEFT JOIN boarding_passes bp ON f.flight_id = bp.flight_id 
GROUP BY f.flight_id, f.flight_no, f.scheduled_departure, f.aircraft_code; 

 
CREATE VIEW qntd_voos_por_aeroporto AS  
SELECT   
    a.airport_code,  
    DATE_TRUNC('month', f.scheduled_arrival) AS month,  
    COUNT(f.flight_id) AS flights_received  
FROM flights f  
JOIN airports_data a ON f.arrival_airport = a.airport_code  
GROUP BY a.airport_code, month; 

