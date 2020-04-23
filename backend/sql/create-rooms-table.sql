

USE HMS_DB;

DROP TABLE room;
DROP TABLE roomtype;

CREATE TABLE roomtype (
    id VARCHAR(2) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    base_price DECIMAL(6,2) NOT NULL,
    num_beds TINYINT,
    max_occupancy TINYINT
);

CREATE TABLE room (
	id SMALLINT PRIMARY KEY,
	in_service BOOLEAN NOT NULL,
	roomtype VARCHAR(2) NOT NULL,
	FOREIGN KEY (roomtype) REFERENCES roomtype(id)
);

INSERT INTO roomtype VALUES ('KI', 'King','Non-smoking room with king-size bed', 79.99, 1, 2);
INSERT INTO roomtype VALUES ('QD', 'Double Queen', 'Non-smoking room with two queen-size beds', 89.99, 2, 4);
INSERT INTO roomtype VALUES ('KS', 'King Suite', 'Non-smoking suite with king-size bed and pull-out couch', 99.99, 2, 4);
INSERT INTO roomtype VALUES ('QS', 'Double Queen Suite', 'Non-smoking room with two queen-size beds and a pull-out couch', 109.99, 3, 6);
INSERT INTO roomtype VALUES ('KJ', 'King Jacuzzi Suite', 'Non-smoking room with a king-size bed and a jacuzzi tub', 129.99, 1, 2);

INSERT INTO room VALUES (100, true, 'KI');
INSERT INTO room VALUES (101, true, 'QD');
INSERT INTO room VALUES (102, true, 'KS');
INSERT INTO room VALUES (103, true, 'QD');
INSERT INTO room VALUES (104, true, 'QS');
INSERT INTO room VALUES (105, true, 'QD');
INSERT INTO room VALUES (106, false, 'KJ');
INSERT INTO room VALUES (107, true, 'QD');
INSERT INTO room VALUES (200, true, 'KJ');
INSERT INTO room VALUES (201, true, 'QS');
INSERT INTO room VALUES (202, true, 'KS');
INSERT INTO room VALUES (203, false, 'KI');
INSERT INTO room VALUES (204, true, 'QD');
INSERT INTO room VALUES (205, true, 'QD');
INSERT INTO room VALUES (206, true, 'KI');
INSERT INTO room VALUES (207, true, 'QS');









