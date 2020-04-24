USE HMS_DB;

-- USER DATA
INSERT INTO user VALUES ('admin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','bill','nye','admin');
INSERT INTO user VALUES ('user', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','john','doe','user');
INSERT INTO user VALUES ('lhershberger', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','logan','hershberger','admin');
INSERT INTO user VALUES ('nbaqibillah', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','nusaiba','baqibillah','admin');
INSERT INTO user VALUES ('aszelestey', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','alex','szelestey','admin');
INSERT INTO user VALUES ('zmarvin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','zac','marvin','admin');
INSERT INTO user VALUES ('kelinkowski', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','keith','elinkowski','admin');
INSERT INTO user VALUES ('emusk', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','elon','musk','user');

-- ROOMTYPE DATA
INSERT INTO roomtype VALUES ('KI', 'King','Non-smoking room with king-size bed', 79.99, 1, 2);
INSERT INTO roomtype VALUES ('QD', 'Double Queen', 'Non-smoking room with two queen-size beds', 89.99, 2, 4);
INSERT INTO roomtype VALUES ('KS', 'King Suite', 'Non-smoking suite with king-size bed and pull-out couch', 99.99, 2, 4);
INSERT INTO roomtype VALUES ('QS', 'Double Queen Suite', 'Non-smoking room with two queen-size beds and a pull-out couch', 109.99, 3, 6);
INSERT INTO roomtype VALUES ('KJ', 'King Jacuzzi Suite', 'Non-smoking room with a king-size bed and a jacuzzi tub', 129.99, 1, 2);
