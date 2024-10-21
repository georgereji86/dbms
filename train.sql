CREATE OR REPLACE PROCEDURE ReserveTicket (
    P_train_number IN INT,
    p_seats_needed IN INT
) AS
    v_available_seats INT;
    v_remaining_seats INT;
BEGIN
    SELECT Seats INTO v_available_seats
    FROM Train
    WHERE TNO = P_train_number;

    IF v_available_seats >= p_seats_needed THEN
        UPDATE Train
        SET Seats = Seats - p_seats_needed
        WHERE TNO = P_train_number;

        COMMIT;

        -- Get the remaining seats
        SELECT Seats INTO v_remaining_seats
        FROM Train
        WHERE TNO = P_train_number;

        DBMS_OUTPUT.PUT_LINE(p_seats_needed || ' seats reserved successfully.');
        DBMS_OUTPUT.PUT_LINE('Remaining seats: ' || v_remaining_seats);
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sorry, not enough seats available.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid train number');
END ReserveTicket;
/

CREATE OR REPLACE PROCEDURE CancelTicket (
    p_train_number IN INT,
    p_seats_cancel IN INT
) AS
    v_remaining_seats INT;
BEGIN
    UPDATE Train
    SET Seats = Seats + p_seats_cancel
    WHERE TNO = p_train_number;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid train number');
    ELSE
        COMMIT;  

        -- Get the remaining seats
        SELECT Seats INTO v_remaining_seats
        FROM Train
        WHERE TNO = p_train_number;

        DBMS_OUTPUT.PUT_LINE(p_seats_cancel || ' seats cancelled successfully');
        DBMS_OUTPUT.PUT_LINE('Remaining seats: ' || v_remaining_seats);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END CancelTicket;
/

