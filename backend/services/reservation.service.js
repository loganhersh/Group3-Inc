const db = require('../db/db');


const reservationTable = "RESERVATION";


module.exports = {
  getReservationByName,
  getReservationById,
  getReservationByRoom
}

const reservationSelectQuery = "SELECT r.reservation_id AS 'ReservationID', r.room_id AS 'RoomNumber'"
    + ", r.roomtype_id AS 'RoomType', DATE_FORMAT(r.check_in_date, '%Y-%m-%e') AS 'CheckIn'"
    + ", DATE_FORMAT(r.check_out_date, '%Y-%m-%e') AS 'CheckOut'"
    + ", CONCAT(g.guest_lastname, ', ', g.guest_firstname) AS 'FullName'"
    + ", g.guest_email AS 'Email', g.guest_phone AS 'Phone', g.guest_street AS 'Street'"
    + ", g.guest_city AS 'City', g.guest_state AS 'State', g.guest_zip AS 'Zip' "
    + "FROM reservation AS r "
    + "INNER JOIN guest AS g "
    + "ON r.guest_id=g.guest_id "
    + "WHERE ??.?? = ?";


function getReservationByName(name) {
  const values = ['g', 'guest_lastname', name];

  return new Promise((resolve, reject) => {
    db.query(reservationSelectQuery, values, (error, results) => {
      if(error) {
        reject(error);
      } else {
        resolve(results);
      }
    })
  });
}


function getReservationById(id) {
  const values = ['r', 'reservation_id', id];

  return new Promise((resolve, reject) => {
    db.query(reservationSelectQuery, values, (error, results) => {
      if(error) {
        reject(error);
      } else {
        resolve(results);
      }
    })
  });
}


function getReservationByRoom(room) {
  const values = ['r', 'room_id', room];

  return new Promise((resolve, reject) => {
    db.query(reservationSelectQuery, values, (error, results) => {
      if(error) {
        reject(error);
      } else {
        resolve(results);
      }
    })
  });
}











