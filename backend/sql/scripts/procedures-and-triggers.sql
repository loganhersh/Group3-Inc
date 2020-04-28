
DELIMITER $$

-- Adds a row in the availability table for each room type
DROP PROCEDURE IF EXISTS day_avail_fill $$
CREATE PROCEDURE day_avail_fill(d DATE)
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE type VARCHAR(2);
    DECLARE roomtype_cursor CURSOR FOR SELECT type_id FROM ROOMTYPE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN roomtype_cursor;
    row_loop: LOOP
        FETCH roomtype_cursor INTO type;
        IF done THEN
            LEAVE row_loop;
        END IF;

        INSERT INTO availability VALUES(d, type, 0);
    END LOOP;
END $$


-- Pre-populates the availability table
DROP PROCEDURE IF EXISTS avail_table_fill $$
CREATE PROCEDURE avail_table_fill()
BEGIN
    DECLARE d DATE;
    DECLARE n INT;
    SET d = CURRENT_DATE();
    SET n = 0;

    WHILE n < 365 DO
            CALL day_avail_fill(d);
            SET d = DATE_ADD(d, INTERVAL 1 DAY);
            SET n = n + 1;
        END WHILE;
END $$

DELIMITER ;


CALL avail_table_fill();


DELIMITER $$


-- Create invoice after new reservation
CREATE TRIGGER ins_invoice_after_reservation AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
        INSERT INTO invoice VALUES (new.reservation_id, 0, 0);
    END $$


 -- Creates trigger that updates availability table when a reservation is created
CREATE TRIGGER upd_avail_after_ins AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
        DECLARE x INT;
        DECLARE num_days INT;
        SET x = 0;
        SET num_days = DATEDIFF(new.check_out_date, new.check_in_date);
        WHILE x < num_days DO
            UPDATE availability
            SET num_reserved = (num_reserved + 1)
            WHERE ((date = DATE_ADD(new.check_in_date, INTERVAL x DAY)) AND
                   (roomtype = new.roomtype_id));
            SET x = x + 1;
            END WHILE;
    END $$

-- Creates trigger that updates availability table when a reservation is deleted
CREATE TRIGGER upd_avail_after_delete AFTER DELETE ON reservation
    FOR EACH ROW
    BEGIN
        DECLARE x INT;
        DECLARE num_days INT;
        SET x = 0;
        SET num_days = DATEDIFF(old.check_out_date, old.check_in_date);
        WHILE x < num_days DO
            UPDATE availability
            SET num_reserved = (num_reserved - 1)
            WHERE ((date = DATE_ADD(old.check_in_date, INTERVAL x DAY)) AND
                   (roomtype = old.roomtype_id));
            SET x = x + 1;
            END WHILE;
    END $$


-- Creates trigger that updates availability table when a reservation is updated
CREATE TRIGGER upd_avail_after_update AFTER UPDATE ON reservation
    FOR EACH ROW
    BEGIN
        DECLARE x INT;
        DECLARE num_days INT;
        SET x = 0;
        SET num_days = DATEDIFF(old.check_out_date, old.check_in_date);

        IF ((new.check_in_date != old.check_in_date) OR (new.check_out_date != old.check_out_date)) THEN
            -- remove old reservation
            WHILE x < num_days DO
                UPDATE availability
                SET num_reserved = (num_reserved - 1)
                WHERE ((date = DATE_ADD(old.check_in_date, INTERVAL x DAY)) AND
                       (roomtype = old.roomtype_id));
                SET x = x + 1;
                END WHILE;

            -- add new reservation
            WHILE x < num_days DO
                UPDATE availability
                SET num_reserved = (num_reserved + 1)
                WHERE ((date = DATE_ADD(new.check_in_date, INTERVAL x DAY)) AND
                       (roomtype = new.roomtype_id));
                SET x = x + 1;
                END WHILE;
        END IF;
    END $$


-- Creates trigger that updates amount paid on invoice when a payment is inserted
CREATE TRIGGER upd_invoice_after_payment AFTER INSERT ON payment
    FOR EACH ROW
    BEGIN
        UPDATE invoice
        SET amount_paid = amount_paid + new.payment_amount
        WHERE invoice_id = new.invoice_id;
    END $$


-- Creates trigger that updates invoice total when a new invoice charge is inserted
CREATE TRIGGER upd_invoice_after_charge AFTER INSERT ON invoicecharge
    FOR EACH ROW
    BEGIN
        UPDATE invoice
        SET total_amount = total_amount + new.charge_amount
        WHERE invoice_id = new.invoice_id;
    END $$


DELIMITER ;
