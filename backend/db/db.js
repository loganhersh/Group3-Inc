/*
    Creates the mysql connection using the db user with global privileges.
 */

var mysql = require('mysql');
var creds = require('./creds.json');

var connection = mysql.createConnection({
  host : creds.host,
  user : creds.user,
  password : creds.password,
  database : creds.database
});

connection.connect(function(err) {
  if(err)
    console.log(err);
  else
    console.log("Database connected");
});

module.exports = connection;
