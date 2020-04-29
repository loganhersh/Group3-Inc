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
    image_path VARCHAR(50),
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
