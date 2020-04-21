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


// function handleDisconnect() {
//   connection = mysql.createConnection(db_config);
//
//   connection.connect(function(err) {
//     if(err) {
//       console.log("Error connecting to DB");
//       setTimeout(handleDisconnect, 3000);
//     } else {
//       console.log("Database connected");
//     }
//   });
//
//   connection.on('error', function(err) {
//     if(err.code === 'PROTOCOL_CONNECTION_LOST') {
//       handleDisconnect();
//     } else {
//       throw err;
//     }
//   });
// }
//
// handleDisconnect();

module.exports = connection;
