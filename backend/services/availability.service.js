const eachDayOfInterval = require('date-fns/eachDayOfInterval');
const roomService = require('./rooms.service');
const db = require('../db/db');


module.exports = {
  getAvailableRoomsForInterval
};


function getAvailableRoomsForInterval(checkin, checkout) {
  var days = eachDayOfInterval({start: checkin, end: checkout});
  days.pop();

  var promises = [];
  promises.push(roomService.getAllRoomTypeInfo());
  days.forEach(day => {
    promises.push(getRoomsAvailableOnDate(day.toISOString().slice(0,10)));
  });

  return Promise.all(promises);
}

// Returns the available room types for a given day
function getRoomsAvailableOnDate(date) {
  const query = "SELECT roomtype FROM availability WHERE date=? AND isAvailable=true";
  const values = [date];
  return new Promise((resolve, reject) => {
    db.query(query,values,(error, results) => {
      if(error) reject(error);
      var arr = [];
      results.forEach(type => arr.push(type.roomtype));
      resolve(arr);
    });
  });
}


