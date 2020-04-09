/*
	Creates a table for the users of the application.
	Adds an administrator user.
*/
USE HMS_DB;

CREATE TABLE users (
	username VARCHAR(25) PRIMARY KEY,
	password VARCHAR(25) NOT NULL
);

INSERT INTO users VALUES ('admin', 'password');