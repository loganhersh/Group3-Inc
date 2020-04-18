/*
	Creates a table for the users of the application.
	Adds an administrator user.
*/
USE HMS_DB;

DROP TABLE users;

CREATE TABLE users (
	username VARCHAR(25) PRIMARY KEY,
	password VARCHAR(80) NOT NULL,
	firstname VARCHAR(30) NOT NULL,
	lastname VARCHAR(30) NOT NULL,
	role VARCHAR(15) NOT NULL
);

INSERT INTO users VALUES ('admin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Bill','Nye','admin');
INSERT INTO users VALUES ('user', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','John','Doe','user');
INSERT INTO users VALUES ('lhershberger', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Logan','Hershberger','admin');
INSERT INTO users VALUES ('nbaqibillah', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Nusaiba','Baqibillah','admin');
INSERT INTO users VALUES ('aszelestey', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Alex','Szelestey','admin');
INSERT INTO users VALUES ('zmarvin', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Zac','Marvin','admin');
INSERT INTO users VALUES ('kelinkowski', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Keith','Elinkowski','admin');
INSERT INTO users VALUES ('emusk', '$2b$10$hf2WwnBkhwjXNwturHMPTuasjCipC3R3GbB9ERtkSCmMRDy.OcpZe','Elon','Musk','user');

