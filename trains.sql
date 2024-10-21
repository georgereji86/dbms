SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('1. TICKET RESERVATION');
    DBMS_OUTPUT.PUT_LINE('2. TICKET CANCELLATION');
END;
/

DECLARE
    train_no INT := &train_number;   
    seat_need INT := &seats_needed;  
    ch INT := &choice;                
BEGIN
    IF ch = 1 THEN
        ReserveTicket(train_no, seat_need);
    ELSIF ch = 2 THEN
        CancelTicket(train_no, seat_need);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please enter 1 for reservation or 2 for cancellation.');
    END IF;
END;
/

