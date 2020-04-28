-- ROOMTYPE DATA
INSERT INTO ROOMTYPE VALUES ('KI', 'King','Non-smoking room with king-size bed', 79.99, 1, 2);
INSERT INTO ROOMTYPE VALUES ('QD', 'Double Queen', 'Non-smoking room with two queen-size beds', 89.99, 2, 4);
INSERT INTO ROOMTYPE VALUES ('KS', 'King Suite', 'Non-smoking suite with king-size bed and pull-out couch', 99.99, 2, 4);
INSERT INTO ROOMTYPE VALUES ('QS', 'Double Queen Suite', 'Non-smoking room with two queen-size beds and a pull-out couch', 109.99, 3, 6);
INSERT INTO ROOMTYPE VALUES ('KJ', 'King Jacuzzi Suite', 'Non-smoking room with a king-size bed and a jacuzzi tub', 129.99, 1, 2);


INSERT INTO ROOM VALUES (400,true,'KJ');
INSERT INTO ROOM VALUES (973,true,'KJ');
INSERT INTO ROOM VALUES (815,true,'KS');

INSERT INTO GUEST VALUES(1000,'Mandi','Mcwain','MMcwain@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','859-496-6142');
INSERT INTO RESERVATION VALUES ('20200712KJ6930688361497',1000,400,'KJ','2020-07-12','2020-07-13',1);

INSERT INTO GUEST VALUES(1001,'Alverta','Arce','AArce@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','989-669-7924');
INSERT INTO RESERVATION VALUES ('20200618KS2330566724915',1001,815,'KS','2020-06-18','2020-06-20',2);

INSERT INTO GUEST VALUES(1002,'Liliana','Lueck','LLueck@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','348-970-1062');
INSERT INTO RESERVATION VALUES ('20200712KJ8098040208823',1002,973,'KJ','2020-07-12','2020-07-15',3);
