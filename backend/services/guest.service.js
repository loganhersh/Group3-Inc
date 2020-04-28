const db = require('../db/db');

const guestTable = "GUEST";

module.exports = {
  createGuest
};

function createGuest(guest) {
  const query = "INSERT INTO ?? VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
  const values = [
      guestTable,
      null,
      guest.firstname,
      guest.lastname,
      guest.email,
      guest.address.street,
      guest.address.city,
      guest.address.state,
      guest.address.zip,
      guest.phone
  ];

  return new Promise(resolve => {
    db.query(query, values,
        (error, results, fields) => {
          if(error) {
            console.log(error);
            resolve();
          } else {
            resolve({"guest_id":results.insertId});
          }
        });
  });
}
