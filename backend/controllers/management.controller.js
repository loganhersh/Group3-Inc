const dateFns = require('date-fns');
const reservationService = require('../services/reservation.service');
const roomService = require('../services/rooms.service');



module.exports = {
  getOccupancyData
}


async function getOccupancyData(req, res, next) {
  var reservations = reservationService.getReservationsInCalendarYear();
  var roomTotals = roomService.getTotalAvailableRoomsOfEachType();

  Promise.all([reservations, roomTotals]).then(results => {

  })
  .catch(err => {
    console.log(err);
  });
}
