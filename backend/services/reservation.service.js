const addDays = require('date-fns/addDays');
const lightFormat = require('date-fns/lightFormat');
const db = require('../db/db');


const reservationTable = "RESERVATION";


module.exports = {

}

// Probably unneeded
// function getReservationsInNext365(date) {
//   var start = date;
//   var end = addDays(date, 365);
//
//   var query = "SELECT (roomtype_id, check_in_date, num_days) FROM RESERVATION "
//       + "WHERE (check_in_date > ?) AND (check_in_date < ?)";
//   var values = [lightFormat(start, 'yyyy-MM-dd'), lightFormat(end, 'yyyy-MM-dd')];
// }










