USE HMS_DB;

DROP TABLE AVAILABILITY;
DROP TABLE INVOICECHARGE;
DROP TABLE PAYMENT;
DROP TABLE INVOICE;
DROP TABLE RESERVATION;
DROP TABLE GUEST;
DROP TABLE ROOM;
DROP TABLE ROOMTYPE;
DROP TABLE USER;

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
                          PRIMARY KEY (type_id)
);


CREATE TABLE ROOM (
                      room_id INT(4) NOT NULL,
                      room_in_service BOOLEAN NOT NULL,
                      roomtype VARCHAR(2) NOT NULL,
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
                             check_out_date DATE NOT NULL ,
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
      num_reserved INT(3),
      PRIMARY KEY (date, roomtype),
      FOREIGN KEY (roomtype) REFERENCES ROOMTYPE(type_id)
);


USE HMS_DB;

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
INSERT INTO ROOMTYPE VALUES ('KI', 'King','Non-smoking room with king-size bed', 79.99, 1, 2);
INSERT INTO ROOMTYPE VALUES ('QD', 'Double Queen', 'Non-smoking room with two queen-size beds', 89.99, 2, 4);
INSERT INTO ROOMTYPE VALUES ('KS', 'King Suite', 'Non-smoking suite with king-size bed and pull-out couch', 99.99, 2, 4);
INSERT INTO ROOMTYPE VALUES ('QS', 'Double Queen Suite', 'Non-smoking room with two queen-size beds and a pull-out couch', 109.99, 3, 6);
INSERT INTO ROOMTYPE VALUES ('KJ', 'King Jacuzzi Suite', 'Non-smoking room with a king-size bed and a jacuzzi tub', 129.99, 1, 2);




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



USE HMS_DB;


INSERT INTO ROOM VALUES (348,true,'KJ');
INSERT INTO ROOM VALUES (106,true,'KI');
INSERT INTO ROOM VALUES (311,true,'KI');
INSERT INTO ROOM VALUES (655,false,'QS');
INSERT INTO ROOM VALUES (90,true,'KI');
INSERT INTO ROOM VALUES (326,true,'QS');
INSERT INTO ROOM VALUES (9,true,'QD');
INSERT INTO ROOM VALUES (0,true,'KS');
INSERT INTO ROOM VALUES (266,false,'KJ');
INSERT INTO ROOM VALUES (329,true,'QD');
INSERT INTO ROOM VALUES (159,true,'KS');
INSERT INTO ROOM VALUES (902,true,'QS');
INSERT INTO ROOM VALUES (403,true,'KJ');
INSERT INTO ROOM VALUES (114,true,'QD');
INSERT INTO ROOM VALUES (858,true,'KS');
INSERT INTO ROOM VALUES (338,true,'KS');
INSERT INTO ROOM VALUES (712,true,'KS');
INSERT INTO ROOM VALUES (284,true,'QD');
INSERT INTO ROOM VALUES (162,true,'KS');
INSERT INTO ROOM VALUES (180,false,'QD');
INSERT INTO ROOM VALUES (892,true,'QD');
INSERT INTO ROOM VALUES (176,true,'KJ');
INSERT INTO ROOM VALUES (468,true,'KS');
INSERT INTO ROOM VALUES (787,true,'QS');
INSERT INTO ROOM VALUES (240,true,'QD');
INSERT INTO ROOM VALUES (901,true,'KI');
INSERT INTO ROOM VALUES (922,false,'KI');
INSERT INTO ROOM VALUES (243,true,'QS');
INSERT INTO ROOM VALUES (215,true,'QD');
INSERT INTO ROOM VALUES (200,true,'QS');
INSERT INTO ROOM VALUES (34,true,'KI');
INSERT INTO ROOM VALUES (307,true,'KS');
INSERT INTO ROOM VALUES (615,true,'QS');
INSERT INTO ROOM VALUES (641,true,'QD');
INSERT INTO ROOM VALUES (719,true,'QD');
INSERT INTO ROOM VALUES (675,true,'KJ');
INSERT INTO ROOM VALUES (59,true,'QD');
INSERT INTO ROOM VALUES (494,true,'QD');
INSERT INTO ROOM VALUES (26,true,'KS');
INSERT INTO ROOM VALUES (806,false,'KJ');
INSERT INTO ROOM VALUES (343,true,'QS');
INSERT INTO ROOM VALUES (91,true,'KI');
INSERT INTO ROOM VALUES (353,true,'QS');
INSERT INTO ROOM VALUES (435,true,'QD');
INSERT INTO ROOM VALUES (11,true,'KS');
INSERT INTO ROOM VALUES (465,true,'QD');
INSERT INTO ROOM VALUES (795,true,'QD');
INSERT INTO ROOM VALUES (617,true,'QS');
INSERT INTO ROOM VALUES (785,true,'QS');
INSERT INTO ROOM VALUES (209,true,'KS');
-- ------- SAMPLE 0 ----------
INSERT INTO GUEST VALUES(1000,'Delora','Delph','DDelph@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','585-403-6010');
INSERT INTO RESERVATION VALUES ('20200606QD4682080926569',1000,59,'QD','2020-06-06','2020-06-09');
INSERT INTO INVOICECHARGE VALUES ('20200606QD4682080926569-ch00001','20200606QD4682080926569','2020-06-06',287.86,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200606QD4682080926569-p00001','20200606QD4682080926569','2020-04-30','CA',244);
-- ------- SAMPLE 1 ----------
INSERT INTO GUEST VALUES(1001,'Lakenya','Langston','LLangston@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','201-059-5634');
INSERT INTO RESERVATION VALUES ('20210427KI6879528387203',1001,901,'KI','2021-04-27','2021-04-29');
INSERT INTO INVOICECHARGE VALUES ('20210427KI6879528387203-ch00001','20210427KI6879528387203','2021-04-27',170.58,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20210427KI6879528387203-p00001','20210427KI6879528387203','2020-04-30','CA',170.58);
-- ------- SAMPLE 2 ----------
INSERT INTO GUEST VALUES(1002,'Deandre','Defore','DDefore@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','775-708-2842');
INSERT INTO RESERVATION VALUES ('20210112KJ5749027935127',1002,176,'KJ','2021-01-12','2021-01-15');
-- ------- SAMPLE 3 ----------
INSERT INTO GUEST VALUES(1003,'Lillia','Linen','LLinen@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','409-922-9816');
INSERT INTO RESERVATION VALUES ('20201214QD1596045567126',1003,329,'QD','2020-12-14','2020-12-17');
INSERT INTO INVOICECHARGE VALUES ('20201214QD1596045567126-ch00001','20201214QD1596045567126','2020-12-14',287.86,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201214QD1596045567126-p00001','20201214QD1596045567126','2020-04-30','CC',287.86,'Lillia Linen','6943202748623177',9,2027,703,'Mastercard');
-- ------- SAMPLE 4 ----------
INSERT INTO GUEST VALUES(1004,'Shad','Sitler','SSitler@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','229-941-4260');
INSERT INTO RESERVATION VALUES ('20200904QD6529105913908',1004,240,'QD','2020-09-04','2020-09-07');
INSERT INTO INVOICECHARGE VALUES ('20200904QD6529105913908-ch00001','20200904QD6529105913908','2020-09-04',189.98,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200904QD6529105913908-ch00002','20200904QD6529105913908','2020-09-04',97.87,'Room Service');
INSERT INTO PAYMENT VALUES ('20200904QD6529105913908-p00001','20200904QD6529105913908','2020-04-30','CC',287.86,'Shad Sitler','1942808145874435',2,2024,880,'Mastercard');
-- ------- SAMPLE 5 ----------
INSERT INTO GUEST VALUES(1005,'Lynda','Linda','LLinda@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','173-391-8669');
INSERT INTO RESERVATION VALUES ('20210417QD9671679794046',1005,795,'QD','2021-04-17','2021-04-18');
INSERT INTO INVOICECHARGE VALUES ('20210417QD9671679794046-ch00001','20210417QD9671679794046','2021-04-17',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210417QD9671679794046-ch00002','20210417QD9671679794046','2021-04-17',32.62,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210417QD9671679794046-p00001','20210417QD9671679794046','2020-04-30','CC',95.95,'Lynda Linda','6836269375940197',7,2021,543,'Mastercard');
-- ------- SAMPLE 6 ----------
INSERT INTO GUEST VALUES(1006,'Mandi','Mcwain','MMcwain@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','211-759-6601');
INSERT INTO RESERVATION VALUES ('20201218KS1204633828873',1006,0,'KS','2020-12-18','2020-12-19');
INSERT INTO INVOICECHARGE VALUES ('20201218KS1204633828873-ch00001','20201218KS1204633828873','2020-12-18',106.61,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201218KS1204633828873-p00001','20201218KS1204633828873','2020-04-30','CC',106.61,'Mandi Mcwain','6101798091859061',9,2022,743,'Mastercard');
-- ------- SAMPLE 7 ----------
INSERT INTO GUEST VALUES(1007,'Fiona','Figgs','FFiggs@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','507-278-0669');
INSERT INTO RESERVATION VALUES ('20201004KS1636779794300',1007,209,'KS','2020-10-04','2020-10-07');
INSERT INTO INVOICECHARGE VALUES ('20201004KS1636779794300-ch00001','20201004KS1636779794300','2020-10-04',211.1,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201004KS1636779794300-ch00002','20201004KS1636779794300','2020-10-04',108.75,'Room Service');
INSERT INTO PAYMENT VALUES ('20201004KS1636779794300-p00001','20201004KS1636779794300','2020-04-30','CC',319.84,'Fiona Figgs','7627595397578052',6,2025,891,'Mastercard');
-- ------- SAMPLE 8 ----------
INSERT INTO GUEST VALUES(1008,'Lynda','Linda','LLinda@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','012-743-4469');
INSERT INTO RESERVATION VALUES ('20210514QS1833813607113',1008,655,'QS','2021-05-14','2021-05-16');
INSERT INTO INVOICECHARGE VALUES ('20210514QS1833813607113-ch00001','20210514QS1833813607113','2021-05-14',154.81,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210514QS1833813607113-ch00002','20210514QS1833813607113','2021-05-14',79.75,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210514QS1833813607113-p00001','20210514QS1833813607113','2020-04-30','CC',234.55,'Lynda Linda','8833449216603533',8,2023,921,'Mastercard');
-- ------- SAMPLE 9 ----------
INSERT INTO GUEST VALUES(1009,'Erminia','Eckard','EEckard@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','914-172-5297');
INSERT INTO RESERVATION VALUES ('20200812KI6607829991018',1009,922,'KI','2020-08-12','2020-08-15');
INSERT INTO INVOICECHARGE VALUES ('20200812KI6607829991018-ch00001','20200812KI6607829991018','2020-08-12',168.87,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200812KI6607829991018-ch00002','20200812KI6607829991018','2020-08-12',87,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20200812KI6607829991018-p00001','20200812KI6607829991018','2020-04-30','CC',211,'Erminia Eckard','6854549604994687',5,2026,887,'Mastercard');
-- ------- SAMPLE 10 ----------
INSERT INTO GUEST VALUES(1010,'Abdul','Ashe','AAshe@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','875-819-0845');
INSERT INTO RESERVATION VALUES ('20210415KI2355562472156',1010,922,'KI','2021-04-15','2021-04-17');
-- ------- SAMPLE 11 ----------
INSERT INTO GUEST VALUES(1011,'Jenna','Jesse','JJesse@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','427-159-9019');
INSERT INTO RESERVATION VALUES ('20200725KS6689356499682',1011,858,'KS','2020-07-25','2020-07-27');
INSERT INTO INVOICECHARGE VALUES ('20200725KS6689356499682-ch00001','20200725KS6689356499682','2020-07-25',140.73,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200725KS6689356499682-ch00002','20200725KS6689356499682','2020-07-25',72.5,'Room Service');
INSERT INTO PAYMENT VALUES ('20200725KS6689356499682-p00001','20200725KS6689356499682','2020-04-30','CC',213.23,'Jenna Jesse','3809314782822166',10,2027,76,'Mastercard');
-- ------- SAMPLE 12 ----------
INSERT INTO GUEST VALUES(1012,'Marylynn','Musson','MMusson@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','047-787-1774');
INSERT INTO RESERVATION VALUES ('20200608QD8115521492796',1012,59,'QD','2020-06-08','2020-06-09');
INSERT INTO INVOICECHARGE VALUES ('20200608QD8115521492796-ch00001','20200608QD8115521492796','2020-06-08',95.95,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200608QD8115521492796-p00001','20200608QD8115521492796','2020-04-30','CA',95.95);
-- ------- SAMPLE 13 ----------
INSERT INTO GUEST VALUES(1013,'Jammie','Jo','JJo@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','323-921-2438');
INSERT INTO RESERVATION VALUES ('20200525KS6420199416968',1013,307,'KS','2020-05-25','2020-05-28');
INSERT INTO INVOICECHARGE VALUES ('20200525KS6420199416968-ch00001','20200525KS6420199416968','2020-05-25',211.1,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200525KS6420199416968-ch00002','20200525KS6420199416968','2020-05-25',108.75,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20200525KS6420199416968-p00001','20200525KS6420199416968','2020-04-30','CC',238,'Jammie Jo','3204720370001816',8,2025,513,'Mastercard');
-- ------- SAMPLE 14 ----------
INSERT INTO GUEST VALUES(1014,'Selene','Staiger','SStaiger@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','536-097-2835');
INSERT INTO RESERVATION VALUES ('20210225KI3454575867379',1014,106,'KI','2021-02-25','2021-02-28');
INSERT INTO INVOICECHARGE VALUES ('20210225KI3454575867379-ch00001','20210225KI3454575867379','2021-02-25',255.87,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210225KI3454575867379-p00001','20210225KI3454575867379','2020-04-30','CC',255.87,'Selene Staiger','7454585809929047',6,2022,300,'Mastercard');
-- ------- SAMPLE 15 ----------
INSERT INTO GUEST VALUES(1015,'James','Janey','JJaney@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','070-973-6999');
INSERT INTO RESERVATION VALUES ('20210201KI4721780154839',1015,311,'KI','2021-02-01','2021-02-03');
INSERT INTO INVOICECHARGE VALUES ('20210201KI4721780154839-ch00001','20210201KI4721780154839','2021-02-01',112.58,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210201KI4721780154839-ch00002','20210201KI4721780154839','2021-02-01',58,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20210201KI4721780154839-p00001','20210201KI4721780154839','2020-04-30','CA',170.58);
-- ------- SAMPLE 16 ----------
INSERT INTO GUEST VALUES(1016,'Melaine','Miskell','MMiskell@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','185-257-4973');
INSERT INTO RESERVATION VALUES ('20201029KI2768116731858',1016,922,'KI','2020-10-29','2020-10-30');
-- ------- SAMPLE 17 ----------
INSERT INTO GUEST VALUES(1017,'Rickie','Redfern','RRedfern@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','747-328-2608');
INSERT INTO RESERVATION VALUES ('20200708QD4678158414588',1017,215,'QD','2020-07-08','2020-07-10');
INSERT INTO INVOICECHARGE VALUES ('20200708QD4678158414588-ch00001','20200708QD4678158414588','2020-07-08',126.66,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200708QD4678158414588-ch00002','20200708QD4678158414588','2020-07-08',65.25,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20200708QD4678158414588-p00001','20200708QD4678158414588','2020-04-30','CC',100,'Rickie Redfern','3926703758325516',6,2021,377,'Mastercard');
-- ------- SAMPLE 18 ----------
INSERT INTO GUEST VALUES(1018,'Fonda','Foreman','FForeman@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','254-633-9674');
INSERT INTO RESERVATION VALUES ('20200704KJ1402601945039',1018,348,'KJ','2020-07-04','2020-07-06');
INSERT INTO INVOICECHARGE VALUES ('20200704KJ1402601945039-ch00001','20200704KJ1402601945039','2020-07-04',182.95,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200704KJ1402601945039-ch00002','20200704KJ1402601945039','2020-07-04',94.25,'Room Service');
INSERT INTO PAYMENT VALUES ('20200704KJ1402601945039-p00001','20200704KJ1402601945039','2020-04-30','CC',277.2,'Fonda Foreman','7790992415232106',4,2027,165,'Mastercard');
-- ------- SAMPLE 19 ----------
INSERT INTO GUEST VALUES(1019,'Kaley','Kilmon','KKilmon@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','548-304-1866');
INSERT INTO RESERVATION VALUES ('20210203KS1958779437511',1019,159,'KS','2021-02-03','2021-02-04');
INSERT INTO INVOICECHARGE VALUES ('20210203KS1958779437511-ch00001','20210203KS1958779437511','2021-02-03',70.37,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210203KS1958779437511-ch00002','20210203KS1958779437511','2021-02-03',36.25,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210203KS1958779437511-p00001','20210203KS1958779437511','2020-04-30','CC',106.61,'Kaley Kilmon','7853099151964214',10,2025,722,'Mastercard');
-- ------- SAMPLE 20 ----------
INSERT INTO GUEST VALUES(1020,'Freida','Forbis','FForbis@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','405-081-4784');
INSERT INTO RESERVATION VALUES ('20201017QD2445675884335',1020,114,'QD','2020-10-17','2020-10-18');
INSERT INTO INVOICECHARGE VALUES ('20201017QD2445675884335-ch00001','20201017QD2445675884335','2020-10-17',95.95,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201017QD2445675884335-p00001','20201017QD2445675884335','2020-04-30','CC',95.95,'Freida Forbis','7980232975137555',5,2023,789,'Mastercard');
-- ------- SAMPLE 21 ----------
INSERT INTO GUEST VALUES(1021,'Linwood','Layden','LLayden@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','828-088-1032');
INSERT INTO RESERVATION VALUES ('20200820KS2640884552380',1021,858,'KS','2020-08-20','2020-08-21');
-- ------- SAMPLE 22 ----------
INSERT INTO GUEST VALUES(1022,'Abram','Adolph','AAdolph@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','878-724-6896');
INSERT INTO RESERVATION VALUES ('20201201QS6739165057526',1022,785,'QS','2020-12-01','2020-12-04');
-- ------- SAMPLE 23 ----------
INSERT INTO GUEST VALUES(1023,'Jenna','Jesse','JJesse@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','376-114-8968');
INSERT INTO RESERVATION VALUES ('20201005KS3872786164503',1023,712,'KS','2020-10-05','2020-10-07');
-- ------- SAMPLE 24 ----------
INSERT INTO GUEST VALUES(1024,'James','Janey','JJaney@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','909-677-4949');
INSERT INTO RESERVATION VALUES ('20210118KS6437813810164',1024,159,'KS','2021-01-18','2021-01-19');
INSERT INTO INVOICECHARGE VALUES ('20210118KS6437813810164-ch00001','20210118KS6437813810164','2021-01-18',70.37,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210118KS6437813810164-ch00002','20210118KS6437813810164','2021-01-18',36.25,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210118KS6437813810164-p00001','20210118KS6437813810164','2020-04-30','CC',79,'James Janey','8619106129297867',10,2022,120,'Mastercard');
-- ------- SAMPLE 25 ----------
INSERT INTO GUEST VALUES(1025,'Shandi','Scharf','SScharf@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','825-203-7730');
INSERT INTO RESERVATION VALUES ('20200721KS7203475630334',1025,26,'KS','2020-07-21','2020-07-22');
INSERT INTO INVOICECHARGE VALUES ('20200721KS7203475630334-ch00001','20200721KS7203475630334','2020-07-21',70.37,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200721KS7203475630334-ch00002','20200721KS7203475630334','2020-07-21',36.25,'Room Service');
INSERT INTO PAYMENT VALUES ('20200721KS7203475630334-p00001','20200721KS7203475630334','2020-04-30','CC',68,'Shandi Scharf','5183946790698679',3,2022,907,'Mastercard');
-- ------- SAMPLE 26 ----------
INSERT INTO GUEST VALUES(1026,'Bradley','Bently','BBently@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','860-434-6884');
INSERT INTO RESERVATION VALUES ('20210504QD5478047078070',1026,435,'QD','2021-05-04','2021-05-07');
INSERT INTO INVOICECHARGE VALUES ('20210504QD5478047078070-ch00001','20210504QD5478047078070','2021-05-04',287.86,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210504QD5478047078070-p00001','20210504QD5478047078070','2020-04-30','CC',287.86,'Bradley Bently','9037305799238761',11,2021,966,'Mastercard');
-- ------- SAMPLE 27 ----------
INSERT INTO GUEST VALUES(1027,'Leanora','Locke','LLocke@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','374-370-8776');
INSERT INTO RESERVATION VALUES ('20210124QD8477309263803',1027,240,'QD','2021-01-24','2021-01-27');
INSERT INTO INVOICECHARGE VALUES ('20210124QD8477309263803-ch00001','20210124QD8477309263803','2021-01-24',189.98,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210124QD8477309263803-ch00002','20210124QD8477309263803','2021-01-24',97.87,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210124QD8477309263803-p00001','20210124QD8477309263803','2020-04-30','CC',287.86,'Leanora Locke','5479920031972729',7,2024,967,'Mastercard');
-- ------- SAMPLE 28 ----------
INSERT INTO GUEST VALUES(1028,'Deangelo','Deloera','DDeloera@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','051-860-2300');
INSERT INTO RESERVATION VALUES ('20201226KS1734045907052',1028,159,'KS','2020-12-26','2020-12-28');
INSERT INTO INVOICECHARGE VALUES ('20201226KS1734045907052-ch00001','20201226KS1734045907052','2020-12-26',140.73,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201226KS1734045907052-ch00002','20201226KS1734045907052','2020-12-26',72.5,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20201226KS1734045907052-p00001','20201226KS1734045907052','2020-04-30','CA',213.23);
-- ------- SAMPLE 29 ----------
INSERT INTO GUEST VALUES(1029,'Walker','Weatherhead','WWeatherhead@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','732-192-8103');
INSERT INTO RESERVATION VALUES ('20200813QS7571055244893',1029,343,'QS','2020-08-13','2020-08-14');
INSERT INTO INVOICECHARGE VALUES ('20200813QS7571055244893-ch00001','20200813QS7571055244893','2020-08-13',117.28,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200813QS7571055244893-p00001','20200813QS7571055244893','2020-04-30','CC',117.28,'Walker Weatherhead','9091437083044528',10,2022,777,'Mastercard');
-- ------- SAMPLE 30 ----------
INSERT INTO GUEST VALUES(1030,'Shad','Sitler','SSitler@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','290-893-3893');
INSERT INTO RESERVATION VALUES ('20210121KJ8295436703333',1030,348,'KJ','2021-01-21','2021-01-24');
INSERT INTO INVOICECHARGE VALUES ('20210121KJ8295436703333-ch00001','20210121KJ8295436703333','2021-01-21',274.43,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210121KJ8295436703333-ch00002','20210121KJ8295436703333','2021-01-21',141.37,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210121KJ8295436703333-p00001','20210121KJ8295436703333','2020-04-30','CC',394,'Shad Sitler','8799046310850902',11,2024,764,'Mastercard');
-- ------- SAMPLE 31 ----------
INSERT INTO GUEST VALUES(1031,'Asa','Allan','AAllan@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','687-792-4642');
INSERT INTO RESERVATION VALUES ('20210417QD6336069507615',1031,795,'QD','2021-04-17','2021-04-19');
INSERT INTO INVOICECHARGE VALUES ('20210417QD6336069507615-ch00001','20210417QD6336069507615','2021-04-17',126.66,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210417QD6336069507615-ch00002','20210417QD6336069507615','2021-04-17',65.25,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210417QD6336069507615-p00001','20210417QD6336069507615','2020-04-30','CC',191.9,'Asa Allan','8385590060698985',2,2022,965,'Mastercard');
-- ------- SAMPLE 32 ----------
INSERT INTO GUEST VALUES(1032,'Malia','Molden','MMolden@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','067-991-9026');
INSERT INTO RESERVATION VALUES ('20200817QD1303600730777',1032,329,'QD','2020-08-17','2020-08-20');
INSERT INTO INVOICECHARGE VALUES ('20200817QD1303600730777-ch00001','20200817QD1303600730777','2020-08-17',287.86,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200817QD1303600730777-p00001','20200817QD1303600730777','2020-04-30','CA',272);
-- ------- SAMPLE 33 ----------
INSERT INTO GUEST VALUES(1033,'Jamey','Jen','JJen@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','416-968-2043');
INSERT INTO RESERVATION VALUES ('20201113KS9630827577221',1033,11,'KS','2020-11-13','2020-11-16');
INSERT INTO INVOICECHARGE VALUES ('20201113KS9630827577221-ch00001','20201113KS9630827577221','2020-11-13',319.84,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201113KS9630827577221-p00001','20201113KS9630827577221','2020-04-30','CC',8,'Jamey Jen','8803534618402776',4,2024,8,'Mastercard');
-- ------- SAMPLE 34 ----------
INSERT INTO GUEST VALUES(1034,'Ginger','Gordillo','GGordillo@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','418-723-6337');
INSERT INTO RESERVATION VALUES ('20201022KI7901233280158',1034,311,'KI','2020-10-22','2020-10-23');
-- ------- SAMPLE 35 ----------
INSERT INTO GUEST VALUES(1035,'Yuette','Yetman','YYetman@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','358-830-6620');
INSERT INTO RESERVATION VALUES ('20210217QD1788411242786',1035,719,'QD','2021-02-17','2021-02-19');
INSERT INTO INVOICECHARGE VALUES ('20210217QD1788411242786-ch00001','20210217QD1788411242786','2021-02-17',191.9,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210217QD1788411242786-p00001','20210217QD1788411242786','2020-04-30','CC',191.9,'Yuette Yetman','1975684753897379',9,2027,166,'Mastercard');
-- ------- SAMPLE 36 ----------
INSERT INTO GUEST VALUES(1036,'Cherry','Chiarello','CChiarello@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','718-783-3079');
INSERT INTO RESERVATION VALUES ('20201214KI7396503149980',1036,91,'KI','2020-12-14','2020-12-17');
INSERT INTO INVOICECHARGE VALUES ('20201214KI7396503149980-ch00001','20201214KI7396503149980','2020-12-14',255.87,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201214KI7396503149980-p00001','20201214KI7396503149980','2020-04-30','CC',255.87,'Cherry Chiarello','6644609315730070',12,2027,852,'Mastercard');
-- ------- SAMPLE 37 ----------
INSERT INTO GUEST VALUES(1037,'Ceola','Carasco','CCarasco@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','583-268-0135');
INSERT INTO RESERVATION VALUES ('20201118QD5362264169162',1037,180,'QD','2020-11-18','2020-11-20');
-- ------- SAMPLE 38 ----------
INSERT INTO GUEST VALUES(1038,'Aretha','Acy','AAcy@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','999-134-1430');
INSERT INTO RESERVATION VALUES ('20200706QD1249543219887',1038,284,'QD','2020-07-06','2020-07-09');
INSERT INTO INVOICECHARGE VALUES ('20200706QD1249543219887-ch00001','20200706QD1249543219887','2020-07-06',287.86,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200706QD1249543219887-p00001','20200706QD1249543219887','2020-04-30','CA',175);
-- ------- SAMPLE 39 ----------
INSERT INTO GUEST VALUES(1039,'Rick','Ritenour','RRitenour@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','534-020-6219');
INSERT INTO RESERVATION VALUES ('20200824KS6496118019390',1039,0,'KS','2020-08-24','2020-08-27');
INSERT INTO INVOICECHARGE VALUES ('20200824KS6496118019390-ch00001','20200824KS6496118019390','2020-08-24',211.1,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200824KS6496118019390-ch00002','20200824KS6496118019390','2020-08-24',108.75,'Room Service');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200824KS6496118019390-p00001','20200824KS6496118019390','2020-04-30','CA',303);