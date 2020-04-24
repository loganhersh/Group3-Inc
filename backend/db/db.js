/*
    Creates the mysql connection using the db user with global privileges.
 */

var mysql = require('mysql');
var creds = require('./creds.json');

var db_config = {
  connectionLimit: 10,
  host: creds.host,
  user: creds.user,
  password : creds.password,
  database : creds.database
};

var connection = mysql.createPool(db_config);

console.log("Database Connected");

module.exports = connection;
