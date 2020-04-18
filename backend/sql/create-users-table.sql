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
