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
