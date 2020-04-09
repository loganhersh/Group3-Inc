// This would normally be a mysql connection
const rooms = require('../db/fakeRoomsDatabase');

module.exports = {
  changeBasePrice
};

function changeBasePrice(roomId, newPrice) {
  /*
      This function would normally set up the MySQL query, then return a Promise
      with the results of actually querying the database. See users.service.js for an example.

      For now, it will simply use the sample JSON data.
   */

  let success = false;

  rooms.forEach(element => {
    if(element.roomId === roomId) {
      element.basePrice = newPrice;
      success = true;
    }
  });

  // Returning the promise is not necessary here, however it is necessary when
  // executing a database query.
  // Typically resolve nothing or false if unsuccessful.
  return new Promise(resolve => {
    if(success === true){
      resolve({message: "Price changed"});
    } else {
      resolve();
    }
  });
}

