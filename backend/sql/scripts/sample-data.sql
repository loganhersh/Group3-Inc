USE HMS_DB;

INSERT INTO ROOM VALUES (810,true,'KJ',true);
INSERT INTO ROOM VALUES (450,true,'QS',true);
INSERT INTO ROOM VALUES (207,false,'KI',true);
INSERT INTO ROOM VALUES (112,true,'KJ',true);
INSERT INTO ROOM VALUES (682,true,'QD',true);
INSERT INTO ROOM VALUES (660,true,'KJ',true);
INSERT INTO ROOM VALUES (355,true,'KS',true);
INSERT INTO ROOM VALUES (853,true,'KS',true);
INSERT INTO ROOM VALUES (610,true,'KI',true);
INSERT INTO ROOM VALUES (32,false,'QD',true);
INSERT INTO ROOM VALUES (666,true,'KJ',true);
INSERT INTO ROOM VALUES (299,false,'KS',true);
INSERT INTO ROOM VALUES (824,true,'KS',true);
INSERT INTO ROOM VALUES (300,true,'QD',true);
INSERT INTO ROOM VALUES (155,false,'KJ',true);
INSERT INTO ROOM VALUES (928,true,'KS',true);
INSERT INTO ROOM VALUES (818,true,'QS',true);
INSERT INTO ROOM VALUES (657,false,'QD',true);
INSERT INTO ROOM VALUES (750,true,'KS',true);
INSERT INTO ROOM VALUES (716,true,'QS',true);
-- ------- SAMPLE 0 ----------
INSERT INTO GUEST VALUES(1000,'Fiona','Figgs','FFiggs@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','902-670-3316');
INSERT INTO RESERVATION VALUES ('20210318KJ8968169812414',1000,660,'KJ','2021-03-18','2021-03-19',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210318KJ8968169812414-ch00001','20210318KJ8968169812414','2021-03-18',138.6,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210318KJ8968169812414-p00001','20210318KJ8968169812414','2020-05-02','CC',138.6,'Fiona Figgs','6235182598866312',12,2023,886,'Mastercard');
-- ------- SAMPLE 1 ----------
INSERT INTO GUEST VALUES(1001,'Hedwig','Hinz','HHinz@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','585-232-7040');
INSERT INTO RESERVATION VALUES ('20201104KI1174745741951',1001,207,'KI','2020-11-04','2020-11-07',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20201104KI1174745741951-ch00001','20201104KI1174745741951','2020-11-04',168.87,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201104KI1174745741951-ch00002','20201104KI1174745741951','2020-11-04',87,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20201104KI1174745741951-p00001','20201104KI1174745741951','2020-05-02','CC',255.87,'Hedwig Hinz','6629435439969835',10,2023,12,'Mastercard');
-- ------- SAMPLE 2 ----------
INSERT INTO GUEST VALUES(1002,'Piedad','Proctor','PProctor@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','976-079-8544');
INSERT INTO RESERVATION VALUES ('20201224KI8017638398282',1002,610,'KI','2020-12-24','2020-12-25',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20201224KI8017638398282-ch00001','20201224KI8017638398282','2020-12-24',85.29,'Base room charge');
INSERT INTO PAYMENT VALUES ('20201224KI8017638398282-p00001','20201224KI8017638398282','2020-05-02','CC',85.29,'Piedad Proctor','4381579727713980',5,2027,294,'Mastercard');
-- ------- SAMPLE 3 ----------
INSERT INTO GUEST VALUES(1003,'Buffy','Beattie','BBeattie@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','728-614-9597');
INSERT INTO RESERVATION VALUES ('20210219KJ3954006653259',1003,155,'KJ','2021-02-19','2021-02-20',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210219KJ3954006653259-ch00001','20210219KJ3954006653259','2021-02-19',138.6,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210219KJ3954006653259-p00001','20210219KJ3954006653259','2020-05-02','CC',138.6,'Buffy Beattie','1816222106870150',10,2026,580,'Mastercard');
-- ------- SAMPLE 4 ----------
INSERT INTO GUEST VALUES(1004,'Eryn','Edenfield','EEdenfield@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','976-432-1721');
INSERT INTO RESERVATION VALUES ('20200805KS9529186868457',1004,750,'KS','2020-08-05','2020-08-08',null,'active');
-- ------- SAMPLE 5 ----------
INSERT INTO GUEST VALUES(1005,'Annie','Albrecht','AAlbrecht@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','023-313-2263');
INSERT INTO RESERVATION VALUES ('20200827QD6081433223874',1005,32,'QD','2020-08-27','2020-08-29',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200827QD6081433223874-ch00001','20200827QD6081433223874','2020-08-27',191.9,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200827QD6081433223874-p00001','20200827QD6081433223874','2020-05-02','CC',191.9,'Annie Albrecht','8721172660037154',5,2022,339,'Mastercard');
-- ------- SAMPLE 6 ----------
INSERT INTO GUEST VALUES(1006,'Tanner','Tomasello','TTomasello@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','305-575-0569');
INSERT INTO RESERVATION VALUES ('20200608KJ5202161010768',1006,810,'KJ','2020-06-08','2020-06-10',null,'active');
-- ------- SAMPLE 7 ----------
INSERT INTO GUEST VALUES(1007,'Hanna','Hastie','HHastie@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','479-991-7016');
INSERT INTO RESERVATION VALUES ('20210201KS2865179334785',1007,824,'KS','2021-02-01','2021-02-02',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210201KS2865179334785-ch00001','20210201KS2865179334785','2021-02-01',106.61,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210201KS2865179334785-p00001','20210201KS2865179334785','2020-05-02','CC',39,'Hanna Hastie','5737715388491541',11,2024,393,'Mastercard');
-- ------- SAMPLE 8 ----------
INSERT INTO GUEST VALUES(1008,'Ginger','Gordillo','GGordillo@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','891-845-2970');
INSERT INTO RESERVATION VALUES ('20210211QS5244154966556',1008,716,'QS','2021-02-11','2021-02-14',null,'active');
-- ------- SAMPLE 9 ----------
INSERT INTO GUEST VALUES(1009,'Shae','Sansom','SSansom@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','645-435-6387');
INSERT INTO RESERVATION VALUES ('20200701QD1756979230558',1009,657,'QD','2020-07-01','2020-07-02',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200701QD1756979230558-ch00001','20200701QD1756979230558','2020-07-01',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200701QD1756979230558-ch00002','20200701QD1756979230558','2020-07-01',32.62,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200701QD1756979230558-p00001','20200701QD1756979230558','2020-05-02','CA',95.95);
-- ------- SAMPLE 10 ----------
INSERT INTO GUEST VALUES(1010,'Dorothea','Dipaolo','DDipaolo@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','061-666-2682');
INSERT INTO RESERVATION VALUES ('20200703KJ5618926442260',1010,112,'KJ','2020-07-03','2020-07-04',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200703KJ5618926442260-ch00001','20200703KJ5618926442260','2020-07-03',138.6,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200703KJ5618926442260-p00001','20200703KJ5618926442260','2020-05-02','CC',138.6,'Dorothea Dipaolo','8999099607595077',3,2026,652,'Mastercard');
-- ------- SAMPLE 11 ----------
INSERT INTO GUEST VALUES(1011,'Liliana','Lueck','LLueck@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','222-767-9318');
INSERT INTO RESERVATION VALUES ('20210502KJ2397397489793',1011,660,'KJ','2021-05-02','2021-05-05',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210502KJ2397397489793-ch00001','20210502KJ2397397489793','2021-05-02',415.81,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20210502KJ2397397489793-p00001','20210502KJ2397397489793','2020-05-02','CA',66);
-- ------- SAMPLE 12 ----------
INSERT INTO GUEST VALUES(1012,'Willian','Wiest','WWiest@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','922-692-5014');
INSERT INTO RESERVATION VALUES ('20210116KS5082167077484',1012,928,'KS','2021-01-16','2021-01-18',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210116KS5082167077484-ch00001','20210116KS5082167077484','2021-01-16',140.73,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210116KS5082167077484-ch00002','20210116KS5082167077484','2021-01-16',72.5,'Room Service');
INSERT INTO PAYMENT VALUES ('20210116KS5082167077484-p00001','20210116KS5082167077484','2020-05-02','CC',213.23,'Willian Wiest','6252427293884874',1,2021,625,'Mastercard');
-- ------- SAMPLE 13 ----------
INSERT INTO GUEST VALUES(1013,'Aretha','Acy','AAcy@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','543-439-6922');
INSERT INTO RESERVATION VALUES ('20200522QD5069241894284',1013,682,'QD','2020-05-22','2020-05-25',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200522QD5069241894284-ch00001','20200522QD5069241894284','2020-05-22',287.86,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200522QD5069241894284-p00001','20200522QD5069241894284','2020-05-02','CC',287.86,'Aretha Acy','1012136333576731',1,2021,666,'Mastercard');
-- ------- SAMPLE 14 ----------
INSERT INTO GUEST VALUES(1014,'Dorothea','Dipaolo','DDipaolo@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','670-848-5377');
INSERT INTO RESERVATION VALUES ('20201028KS5386324265201',1014,355,'KS','2020-10-28','2020-10-29',null,'active');
-- ------- SAMPLE 15 ----------
INSERT INTO GUEST VALUES(1015,'Corene','Carmody','CCarmody@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','429-604-1663');
INSERT INTO RESERVATION VALUES ('20210328QD6328307444421',1015,32,'QD','2021-03-28','2021-03-31',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210328QD6328307444421-ch00001','20210328QD6328307444421','2021-03-28',189.98,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210328QD6328307444421-ch00002','20210328QD6328307444421','2021-03-28',97.87,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20210328QD6328307444421-p00001','20210328QD6328307444421','2020-05-02','CA',287.86);
-- ------- SAMPLE 16 ----------
INSERT INTO GUEST VALUES(1016,'Marcelino','Meisner','MMeisner@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','376-103-5627');
INSERT INTO RESERVATION VALUES ('20200612QD1009433890771',1016,657,'QD','2020-06-12','2020-06-13',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200612QD1009433890771-ch00001','20200612QD1009433890771','2020-06-12',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200612QD1009433890771-ch00002','20200612QD1009433890771','2020-06-12',32.62,'Cleaning fee');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200612QD1009433890771-p00001','20200612QD1009433890771','2020-05-02','CA',95.95);
-- ------- SAMPLE 17 ----------
INSERT INTO GUEST VALUES(1017,'Mandi','Mcwain','MMcwain@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','248-206-4083');
INSERT INTO RESERVATION VALUES ('20200709QD9613431719814',1017,32,'QD','2020-07-09','2020-07-10',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200709QD9613431719814-ch00001','20200709QD9613431719814','2020-07-09',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200709QD9613431719814-ch00002','20200709QD9613431719814','2020-07-09',32.62,'Room Service');
INSERT INTO PAYMENT VALUES ('20200709QD9613431719814-p00001','20200709QD9613431719814','2020-05-02','CC',95.95,'Mandi Mcwain','2436951296275296',8,2027,884,'Mastercard');
-- ------- SAMPLE 18 ----------
INSERT INTO GUEST VALUES(1018,'Boyce','Bate','BBate@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','071-458-7740');
INSERT INTO RESERVATION VALUES ('20201101KJ4477014169003',1018,660,'KJ','2020-11-01','2020-11-02',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20201101KJ4477014169003-ch00001','20201101KJ4477014169003','2020-11-01',91.48,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201101KJ4477014169003-ch00002','20201101KJ4477014169003','2020-11-01',47.12,'Room Service');
INSERT INTO PAYMENT VALUES ('20201101KJ4477014169003-p00001','20201101KJ4477014169003','2020-05-02','CC',48,'Boyce Bate','6760249088542098',11,2023,217,'Mastercard');
-- ------- SAMPLE 19 ----------
INSERT INTO GUEST VALUES(1019,'Walker','Weatherhead','WWeatherhead@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','231-673-3769');
INSERT INTO RESERVATION VALUES ('20210210KJ7964034039143',1019,155,'KJ','2021-02-10','2021-02-12',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210210KJ7964034039143-ch00001','20210210KJ7964034039143','2021-02-10',182.95,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210210KJ7964034039143-ch00002','20210210KJ7964034039143','2021-02-10',94.25,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210210KJ7964034039143-p00001','20210210KJ7964034039143','2020-05-02','CC',277.2,'Walker Weatherhead','9270839360066088',9,2024,206,'Mastercard');
-- ------- SAMPLE 20 ----------
INSERT INTO GUEST VALUES(1020,'Luella','Lundstrom','LLundstrom@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','215-478-6103');
INSERT INTO RESERVATION VALUES ('20200925KJ9239590501586',1020,155,'KJ','2020-09-25','2020-09-27',null,'active');
-- ------- SAMPLE 21 ----------
INSERT INTO GUEST VALUES(1021,'Reita','Rudder','RRudder@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','873-961-6452');
INSERT INTO RESERVATION VALUES ('20210407KI1580187327442',1021,610,'KI','2021-04-07','2021-04-08',null,'active');
-- ------- SAMPLE 22 ----------
INSERT INTO GUEST VALUES(1022,'Floy','Feinstein','FFeinstein@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','667-401-4010');
INSERT INTO RESERVATION VALUES ('20210214KI3494267493456',1022,207,'KI','2021-02-14','2021-02-17',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210214KI3494267493456-ch00001','20210214KI3494267493456','2021-02-14',255.87,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210214KI3494267493456-p00001','20210214KI3494267493456','2020-05-02','CC',255.87,'Floy Feinstein','6181671278692957',6,2026,242,'Mastercard');
-- ------- SAMPLE 23 ----------
INSERT INTO GUEST VALUES(1023,'Alverta','Arce','AArce@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','576-461-8603');
INSERT INTO RESERVATION VALUES ('20210405QD4002028604744',1023,657,'QD','2021-04-05','2021-04-06',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210405QD4002028604744-ch00001','20210405QD4002028604744','2021-04-05',95.95,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210405QD4002028604744-p00001','20210405QD4002028604744','2020-05-02','CC',84,'Alverta Arce','1011972611982850',3,2022,297,'Mastercard');
-- ------- SAMPLE 24 ----------
INSERT INTO GUEST VALUES(1024,'Leighann','Leith','LLeith@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','970-922-7018');
INSERT INTO RESERVATION VALUES ('20210216QS2841318468100',1024,450,'QS','2021-02-16','2021-02-19',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210216QS2841318468100-ch00001','20210216QS2841318468100','2021-02-16',351.83,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20210216QS2841318468100-p00001','20210216QS2841318468100','2020-05-02','CA',274);
-- ------- SAMPLE 25 ----------
INSERT INTO GUEST VALUES(1025,'Leanora','Locke','LLocke@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','150-527-5764');
INSERT INTO RESERVATION VALUES ('20201027KJ5025185852807',1025,810,'KJ','2020-10-27','2020-10-30',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20201027KJ5025185852807-ch00001','20201027KJ5025185852807','2020-10-27',274.43,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201027KJ5025185852807-ch00002','20201027KJ5025185852807','2020-10-27',141.37,'Room Service');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20201027KJ5025185852807-p00001','20201027KJ5025185852807','2020-05-02','CA',415.81);
-- ------- SAMPLE 26 ----------
INSERT INTO GUEST VALUES(1026,'Kandra','Kelty','KKelty@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','931-980-2089');
INSERT INTO RESERVATION VALUES ('20210411QD7931644193264',1026,32,'QD','2021-04-11','2021-04-12',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210411QD7931644193264-ch00001','20210411QD7931644193264','2021-04-11',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210411QD7931644193264-ch00002','20210411QD7931644193264','2021-04-11',32.62,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20210411QD7931644193264-p00001','20210411QD7931644193264','2020-05-02','CC',95.95,'Kandra Kelty','5760656110246901',12,2025,280,'Mastercard');
-- ------- SAMPLE 27 ----------
INSERT INTO GUEST VALUES(1027,'Kaley','Kilmon','KKilmon@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','912-817-8763');
INSERT INTO RESERVATION VALUES ('20200520QD7728586344052',1027,657,'QD','2020-05-20','2020-05-21',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200520QD7728586344052-ch00001','20200520QD7728586344052','2020-05-20',63.33,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200520QD7728586344052-ch00002','20200520QD7728586344052','2020-05-20',32.62,'Room Service');
INSERT INTO PAYMENT VALUES ('20200520QD7728586344052-p00001','20200520QD7728586344052','2020-05-02','CC',95.95,'Kaley Kilmon','8440516871773465',7,2025,614,'Mastercard');
-- ------- SAMPLE 28 ----------
INSERT INTO GUEST VALUES(1028,'Rossana','Running','RRunning@gmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','546-875-1506');
INSERT INTO RESERVATION VALUES ('20200707KI1389446643765',1028,207,'KI','2020-07-07','2020-07-08',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200707KI1389446643765-ch00001','20200707KI1389446643765','2020-07-07',85.29,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200707KI1389446643765-p00001','20200707KI1389446643765','2020-05-02','CA',85.29);
-- ------- SAMPLE 29 ----------
INSERT INTO GUEST VALUES(1029,'Buffy','Beattie','BBeattie@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','144-113-0121');
INSERT INTO RESERVATION VALUES ('20210209KS6332604281871',1029,853,'KS','2021-02-09','2021-02-11',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210209KS6332604281871-ch00001','20210209KS6332604281871','2021-02-09',213.23,'Base room charge');
INSERT INTO PAYMENT VALUES ('20210209KS6332604281871-p00001','20210209KS6332604281871','2020-05-02','CC',108,'Buffy Beattie','9411934755222179',8,2021,560,'Mastercard');
-- ------- SAMPLE 30 ----------
INSERT INTO GUEST VALUES(1030,'Margorie','Mcnish','MMcnish@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','691-436-0696');
INSERT INTO RESERVATION VALUES ('20200907QD7695379726848',1030,682,'QD','2020-09-07','2020-09-09',null,'active');
-- ------- SAMPLE 31 ----------
INSERT INTO GUEST VALUES(1031,'Shena','Sandoz','SSandoz@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','380-797-7839');
INSERT INTO RESERVATION VALUES ('20210310KS7052553935038',1031,853,'KS','2021-03-10','2021-03-11',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210310KS7052553935038-ch00001','20210310KS7052553935038','2021-03-10',70.37,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210310KS7052553935038-ch00002','20210310KS7052553935038','2021-03-10',36.25,'Room Service');
INSERT INTO PAYMENT VALUES ('20210310KS7052553935038-p00001','20210310KS7052553935038','2020-05-02','CC',1,'Shena Sandoz','9022849243390181',2,2024,408,'Mastercard');
-- ------- SAMPLE 32 ----------
INSERT INTO GUEST VALUES(1032,'Heather','Hartin','HHartin@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','188-505-1788');
INSERT INTO RESERVATION VALUES ('20210322KI7092578958423',1032,610,'KI','2021-03-22','2021-03-23',null,'active');
-- ------- SAMPLE 33 ----------
INSERT INTO GUEST VALUES(1033,'Abram','Adolph','AAdolph@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','898-887-1018');
INSERT INTO RESERVATION VALUES ('20200818KJ2206453359281',1033,666,'KJ','2020-08-18','2020-08-21',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200818KJ2206453359281-ch00001','20200818KJ2206453359281','2020-08-18',415.81,'Base room charge');
INSERT INTO PAYMENT (payment_id,invoice_id,payment_date,payment_type,payment_amount) VALUES ('20200818KJ2206453359281-p00001','20200818KJ2206453359281','2020-05-02','CA',415.81);
-- ------- SAMPLE 34 ----------
INSERT INTO GUEST VALUES(1034,'Walter','Wellington','WWellington@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','837-403-0438');
INSERT INTO RESERVATION VALUES ('20210115QS2726118457231',1034,818,'QS','2021-01-15','2021-01-17',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210115QS2726118457231-ch00001','20210115QS2726118457231','2021-01-15',154.81,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210115QS2726118457231-ch00002','20210115QS2726118457231','2021-01-15',79.75,'Room Service');
INSERT INTO PAYMENT VALUES ('20210115QS2726118457231-p00001','20210115QS2726118457231','2020-05-02','CC',72,'Walter Wellington','3639405415662675',10,2023,798,'Mastercard');
-- ------- SAMPLE 35 ----------
INSERT INTO GUEST VALUES(1035,'Lorean','Loden','LLoden@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','670-011-5886');
INSERT INTO RESERVATION VALUES ('20200801KJ3660834866762',1035,810,'KJ','2020-08-01','2020-08-02',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200801KJ3660834866762-ch00001','20200801KJ3660834866762','2020-08-01',91.48,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20200801KJ3660834866762-ch00002','20200801KJ3660834866762','2020-08-01',47.12,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20200801KJ3660834866762-p00001','20200801KJ3660834866762','2020-05-02','CC',138.6,'Lorean Loden','5097080687545064',9,2026,72,'Mastercard');
-- ------- SAMPLE 36 ----------
INSERT INTO GUEST VALUES(1036,'Kathlyn','Kinser','KKinser@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','536-974-3273');
INSERT INTO RESERVATION VALUES ('20201230KS8656661819969',1036,299,'KS','2020-12-30','2021-01-01',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20201230KS8656661819969-ch00001','20201230KS8656661819969','2020-12-30',140.73,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20201230KS8656661819969-ch00002','20201230KS8656661819969','2020-12-30',72.5,'Cleaning fee');
INSERT INTO PAYMENT VALUES ('20201230KS8656661819969-p00001','20201230KS8656661819969','2020-05-02','CC',99,'Kathlyn Kinser','7865299150652905',7,2026,639,'Mastercard');
-- ------- SAMPLE 37 ----------
INSERT INTO GUEST VALUES(1037,'Jamey','Jen','JJen@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','247-268-7069');
INSERT INTO RESERVATION VALUES ('20200902KS9027696770844',1037,299,'KS','2020-09-02','2020-09-05',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20200902KS9027696770844-ch00001','20200902KS9027696770844','2020-09-02',319.84,'Base room charge');
INSERT INTO PAYMENT VALUES ('20200902KS9027696770844-p00001','20200902KS9027696770844','2020-05-02','CC',319.84,'Jamey Jen','4544969919404834',2,2024,442,'Mastercard');
-- ------- SAMPLE 38 ----------
INSERT INTO GUEST VALUES(1038,'Ginger','Gordillo','GGordillo@yahoo.com','1234 DaWrong Lane','Flonkerton','MD','12345','882-127-7441');
INSERT INTO RESERVATION VALUES ('20200930KS3593922458926',1038,928,'KS','2020-09-30','2020-10-02',null,'active');
-- ------- SAMPLE 39 ----------
INSERT INTO GUEST VALUES(1039,'Linwood','Layden','LLayden@hotmail.com','1234 DaWrong Lane','Flonkerton','MD','12345','671-737-6479');
INSERT INTO RESERVATION VALUES ('20210319KJ2064501218801',1039,810,'KJ','2021-03-19','2021-03-20',null,'active');
INSERT INTO INVOICECHARGE VALUES ('20210319KJ2064501218801-ch00001','20210319KJ2064501218801','2021-03-19',91.48,'Base room charge');
INSERT INTO INVOICECHARGE VALUES ('20210319KJ2064501218801-ch00002','20210319KJ2064501218801','2021-03-19',47.12,'Room Service');
INSERT INTO PAYMENT VALUES ('20210319KJ2064501218801-p00001','20210319KJ2064501218801','2020-05-02','CC',138.6,'Linwood Layden','5513096381945172',7,2021,444,'Mastercard');
