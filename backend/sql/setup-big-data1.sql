\W

/*
	Creates the database and adds a user with global privileges on the database.
*/
DROP DATABASE HMS_DB;
CREATE DATABASE HMS_DB;

/*
	Add user with all privileges for the db.
	Ideally, we would create users for different services and grant only privileges they require.
*/
CREATE USER IF NOT EXISTS 'hms_owner'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password123';
GRANT ALL ON HMS_DB.* TO 'hms_owner'@'localhost';

USE HMS_DB;

CREATE TABLE USER (
    username VARCHAR(25) NOT NULL,
    password VARCHAR(80) NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    role VARCHAR(15) NOT NULL,
    PRIMARY KEY (username)
);


CREATE TABLE ROOMTYPE (
    type_id VARCHAR(2) NOT NULL,
    type_name VARCHAR(50) NOT NULL,
    type_description VARCHAR(255),
    type_base_price DECIMAL(6,2) NOT NULL,
    type_num_beds INT(2),
    type_max_occupancy INT(3),
    image_path VARCHAR(50),
    PRIMARY KEY (type_id)
);


CREATE TABLE ROOM (
    room_id INT(4) NOT NULL,
    room_in_service BOOLEAN NOT NULL,
    roomtype VARCHAR(2) NOT NULL,
    isVacant BOOLEAN NOT NULL,
    PRIMARY KEY (room_id),
    FOREIGN KEY (roomtype) REFERENCES ROOMTYPE(type_id)
);


CREATE TABLE GUEST (
    guest_id INT(10) AUTO_INCREMENT,
    guest_firstname VARCHAR(30) NOT NULL,
    guest_lastname VARCHAR(30) NOT NULL,
    guest_email VARCHAR(50) NOT NULL,
    guest_street VARCHAR(60) NOT NULL,
    guest_city VARCHAR(30) NOT NULL,
    guest_state VARCHAR(2) NOT NULL,
    guest_zip VARCHAR(10) NOT NULL,
    guest_phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (guest_id)
);

ALTER TABLE GUEST AUTO_INCREMENT=1000;


CREATE TABLE RESERVATION (
    reservation_id VARCHAR(40) NOT NULL,
    guest_id INT(10) NOT NULL,
    room_id INT(4),
    roomtype_id VARCHAR(2) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    comments VARCHAR(255),
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (guest_id) REFERENCES GUEST(guest_id),
    FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
    FOREIGN KEY (roomtype_id) REFERENCES ROOMTYPE(type_id)
);


CREATE TABLE INVOICE (
    invoice_id VARCHAR(40) NOT NULL,
    total_amount DECIMAL(6,2) NOT NULL,
    amount_paid DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (invoice_id),
    FOREIGN KEY (invoice_id) REFERENCES RESERVATION(reservation_id)
);


CREATE TABLE PAYMENT (
    payment_id VARCHAR(45) NOT NULL,
    invoice_id VARCHAR(40) NOT NULL,
    payment_date DATE NOT NULL,
    payment_type VARCHAR(2) NOT NULL,
    payment_amount DECIMAL(6,2) NOT NULL,
    accountholder_name VARCHAR(50),
    account_number VARCHAR(20),
    expiration_month INT(2),
    expiration_year YEAR,
    card_cvv INT(5),
    card_network VARCHAR(20),
    PRIMARY KEY (payment_id),
    FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id)
);


CREATE TABLE INVOICECHARGE (
    charge_id VARCHAR(45) NOT NULL,
    invoice_id VARCHAR(40) NOT NULL,
    date_applied DATE NOT NULL,
    charge_amount DECIMAL(6,2) NOT NULL,
    charge_reason VARCHAR(100) NOT NULL,
    PRIMARY KEY (charge_id),
    FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id)
);


CREATE TABLE AVAILABILITY (
    date DATE NOT NULL,
    roomtype VARCHAR(2) NOT NULL,
    num_reserved INT(3) NOT NULL,
    isAvailable BOOLEAN NOT NULL,
    PRIMARY KEY (date, roomtype),
    FOREIGN KEY (roomtype) REFERENCES ROOMTYPE(type_id)
);


-- USER DATA
INSERT INTO USER VALUES ('admin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','bill','nye','admin');
INSERT INTO USER VALUES ('user', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','john','doe','user');
INSERT INTO USER VALUES ('lhershberger', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','logan','hershberger','admin');
INSERT INTO USER VALUES ('nbaqibillah', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','nusaiba','baqibillah','admin');
INSERT INTO USER VALUES ('aszelestey', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','alex','szelestey','admin');
INSERT INTO USER VALUES ('zmarvin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','zac','marvin','admin');
INSERT INTO USER VALUES ('kelinkowski', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','keith','elinkowski','admin');
INSERT INTO USER VALUES ('emusk', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','elon','musk','user');

-- ROOMTYPE DATA
INSERT INTO ROOMTYPE VALUES ('KI', 'King','Non-smoking room with king-size bed', 79.99, 1, 3, '/photos/kingRoom.jpg');
INSERT INTO ROOMTYPE VALUES ('QD', 'Double Queen', 'Non-smoking room with two queen-size beds', 89.99, 2, 5, '/photos/queen-bed.jpg');
INSERT INTO ROOMTYPE VALUES ('KS', 'King Suite', 'Non-smoking suite with king-size bed and pull-out couch', 99.99, 2, 5, '/photos/king.jpg');
INSERT INTO ROOMTYPE VALUES ('QS', 'Double Queen Suite', 'Non-smoking room with two queen-size beds and a pull-out couch', 109.99, 3, 7, '/photos/queen-suite.jpg');
INSERT INTO ROOMTYPE VALUES ('KJ', 'King Jacuzzi Suite', 'Non-smoking room with a king-size bed and a jacuzzi tub', 129.99, 1, 3, '/photos/jacuzzi.jpg');



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

        INSERT INTO AVAILABILITY VALUES(d, type, 0, true);
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


-- Updates isAvailable based on current total number of rooms for given type
DROP PROCEDURE IF EXISTS check_isAvail_after_upd $$
CREATE PROCEDURE check_isAvail_after_upd(type VARCHAR(2), num_reserved INT, d DATE)
BEGIN
    DECLARE num_rooms INT;
    SET num_rooms = (SELECT COUNT(room_id) FROM ROOM WHERE roomtype=type AND room_in_service=true);
    IF (num_rooms > num_reserved) THEN
        UPDATE AVAILABILITY
        SET isAvailable = true
        WHERE date=d AND roomtype=type;
    ELSE
        UPDATE AVAILABILITY
        SET isAvailable = false
        WHERE date=d AND roomtype=type;
    END IF ;
END $$


DELIMITER ;


CALL avail_table_fill();


DELIMITER $$


-- Create invoice after new reservation
CREATE TRIGGER ins_invoice_after_reservation AFTER INSERT ON RESERVATION
    FOR EACH ROW
BEGIN
    INSERT INTO INVOICE VALUES (new.reservation_id, 0, 0);
END $$


-- Updates num_reserved on availability table when a reservation is created
CREATE TRIGGER upd_avail_after_ins AFTER INSERT ON RESERVATION
    FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE num_days INT;
    DECLARE num_res INT;
    DECLARE curr_date DATE;
    SET x = 0;
    SET num_days = DATEDIFF(new.check_out_date, new.check_in_date);
    WHILE x < num_days DO
            SET curr_date = DATE_ADD(new.check_in_date, INTERVAL x DAY);
            UPDATE AVAILABILITY
            SET num_reserved = (num_reserved + 1)
            WHERE ((date = curr_date) AND
                   (roomtype = new.roomtype_id));
            SET x = x + 1;

            SELECT num_reserved INTO num_res FROM AVAILABILITY WHERE date=curr_date AND roomtype=new.roomtype_id;
            CALL check_isAvail_after_upd(new.roomtype_id, num_res, curr_date);

        END WHILE;
END $$

-- Updates num_reserved on availability table when a reservation is cancelled
CREATE TRIGGER upd_avail_after_cancel AFTER UPDATE ON RESERVATION
    FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE num_days INT;
    DECLARE num_res INT;
    DECLARE curr_date DATE;
    SET x = 0;
    SET num_days = DATEDIFF(old.check_out_date, old.check_in_date);

    IF (new.status LIKE 'cancelled' AND old.status NOT LIKE 'cancelled') THEN

        WHILE x < num_days DO
                SET curr_date = DATE_ADD(old.check_in_date, INTERVAL x DAY);
                UPDATE AVAILABILITY
                SET num_reserved = (num_reserved - 1)
                WHERE ((date = curr_date) AND
                       (roomtype = old.roomtype_id));
                SET x = x + 1;

                SELECT num_reserved INTO num_res FROM AVAILABILITY WHERE date=curr_date AND roomtype=old.roomtype_id;
                CALL check_isAvail_after_upd(old.roomtype_id, num_res, curr_date);

            END WHILE;

    END IF ;
END $$


-- Updates num_reserved on availability table when a reservation's dates are updated
CREATE TRIGGER upd_avail_after_update AFTER UPDATE ON RESERVATION
    FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE num_days INT;
    DECLARE num_res INT;
    DECLARE curr_date DATE;
    SET x = 0;
    SET num_days = DATEDIFF(old.check_out_date, old.check_in_date);

    IF ((new.check_in_date != old.check_in_date) OR (new.check_out_date != old.check_out_date)) THEN
        -- remove old reservation
        WHILE x < num_days DO
                UPDATE AVAILABILITY
                SET num_reserved = (num_reserved - 1)
                WHERE ((date = DATE_ADD(old.check_in_date, INTERVAL x DAY)) AND
                       (roomtype = old.roomtype_id));
                SET x = x + 1;
            END WHILE;

        -- add new reservation
        WHILE x < num_days DO
                SET curr_date = DATE_ADD(old.check_in_date, INTERVAL x DAY);
                UPDATE AVAILABILITY
                SET num_reserved = (num_reserved + 1)
                WHERE ((date = curr_date) AND
                       (roomtype = new.roomtype_id));
                SET x = x + 1;

                SELECT num_reserved INTO num_res FROM AVAILABILITY WHERE date=curr_date AND roomtype=new.roomtype_id;
                CALL check_isAvail_after_upd(new.roomtype_id, num_res, curr_date);

            END WHILE;
    END IF;
END $$


-- Updates amount paid on invoice when a payment is inserted
CREATE TRIGGER upd_invoice_after_payment AFTER INSERT ON PAYMENT
    FOR EACH ROW
BEGIN
    UPDATE INVOICE
    SET amount_paid = amount_paid + new.payment_amount
    WHERE invoice_id = new.invoice_id;
END $$


-- Updates invoice total when a new invoice charge is inserted
CREATE TRIGGER upd_invoice_after_charge AFTER INSERT ON INVOICECHARGE
    FOR EACH ROW
BEGIN
    UPDATE INVOICE
    SET total_amount = total_amount + new.charge_amount
    WHERE invoice_id = new.invoice_id;
END $$


DELIMITER ;


USE HMS_DB;

INSERT INTO ROOM VALUES (101,true,'QD',true);
INSERT INTO ROOM VALUES (102,false,'KS',true);
INSERT INTO ROOM VALUES (103,false,'QS',true);
INSERT INTO ROOM VALUES (104,true,'KJ',true);
INSERT INTO ROOM VALUES (105,true,'KI',true);
INSERT INTO ROOM VALUES (106,true,'QD',true);
INSERT INTO ROOM VALUES (107,false,'KS',true);
INSERT INTO ROOM VALUES (108,true,'QS',true);
INSERT INTO ROOM VALUES (109,true,'KJ',true);
INSERT INTO ROOM VALUES (110,true,'KI',true);
INSERT INTO ROOM VALUES (111,false,'QD',true);
INSERT INTO ROOM VALUES (112,false,'KS',true);
INSERT INTO ROOM VALUES (113,false,'QS',true);
INSERT INTO ROOM VALUES (114,true,'KJ',true);
INSERT INTO ROOM VALUES (115,true,'KI',true);
INSERT INTO ROOM VALUES (116,false,'QD',true);
INSERT INTO ROOM VALUES (117,true,'KS',true);
INSERT INTO ROOM VALUES (118,true,'QS',true);
INSERT INTO ROOM VALUES (119,false,'KJ',true);
INSERT INTO ROOM VALUES (120,true,'KI',true);
INSERT INTO ROOM VALUES (200,true,'QD',true);
INSERT INTO ROOM VALUES (201,true,'KS',true);
INSERT INTO ROOM VALUES (202,true,'QS',true);
INSERT INTO ROOM VALUES (203,true,'KJ',true);
INSERT INTO ROOM VALUES (204,true,'KI',true);
INSERT INTO ROOM VALUES (205,true,'QD',true);
INSERT INTO ROOM VALUES (206,true,'KS',true);
INSERT INTO ROOM VALUES (207,true,'QS',true);
INSERT INTO ROOM VALUES (208,true,'KJ',true);
INSERT INTO ROOM VALUES (209,true,'KI',true);

-- ------- SAMPLE 0 ----------
INSERT INTO GUEST VALUES(1000,'Mario','Macdowell','MMacdowell@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','758-495-1819');
INSERT INTO RESERVATION VALUES ('20191201KS7474231210526',1000,117,'KS','2019-12-01','2019-12-04',null,'complete');
INSERT INTO INVOICECHARGE VALUES ('20191201KS7474231210526-ch00001','20191201KS7474231210526','2019-12-01',319.84,'Base room charge');
INSERT INTO PAYMENT VALUES ('20191201KS7474231210526-p00001','20191201KS7474231210526','2020-05-05','CC',221,'Mario Macdowell','7797559556676846',4,2022,521,'Mastercard');
-- ------- SAMPLE 1 ----------
INSERT INTO GUEST VALUES(1001,'Vicky','Vanderhoff','VVanderhoff@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','382-140-1839');
INSERT INTO RESERVATION VALUES ('20200507KI4715972176857',1001,null,'KI','2020-05-07','2020-05-08',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200507KI4715972176857-ch00001','20200507KI4715972176857','2020-05-07',56.29,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200507KI4715972176857-ch00002','20200507KI4715972176857','2020-05-07',29,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200507KI4715972176857-p00001','20200507KI4715972176857','2020-05-05','CA',4);
-- ------- SAMPLE 2 ----------
INSERT INTO GUEST VALUES(1002,'Daron','Dycus','DDycus@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','373-396-5900');
INSERT INTO RESERVATION VALUES ('20200823KS7574645854181',1002,null,'KS','2020-08-23','2020-08-24',null,'cancelled');
INSERT INTO INVOICECHARGE VALUES ('20200823KS7574645854181-ch00001','20200823KS7574645854181','2020-08-23',106.61,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200823KS7574645854181-p00001','20200823KS7574645854181','2020-05-05','CC',106.61,'Daron Dycus','6533004105040345',10,2022,713,'Mastercard');
