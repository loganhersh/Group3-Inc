const dateFns = require('date-fns');
const guestService = require('../services/guest.service');
const reservationService = require('../services/reservation.service');
const availabilityService = require('../services/availability.service');


module.exports = {
  createReservation,
  getByName,
  getById,
  getByRoom,
  getAvailableRooms
};


async function createReservation(req, res, next) {
  var reservation = req.body.reservation;
  var guest = req.body.guest;

  res.status(200).send('12341234SAMPLE12341234');


  // TODO: Verify availability


  // guestService.createGuest(guest).then(guestId => {
  //   if(guestId) {
  //     console.log(guestId);
  //   } else {
  //     console.log("Guest could not be created");
  //   }
  // });

  // TODO: Generate reservation ID


  // TODO: Calculate num days

  // TODO: insert reservation

}


async function getByName(req, res, next) {
  var name = req.params.name;
  reservationService.getReservationByName(name.toLowerCase()).then(results => {
    getReservationCallback(results, res);
  })
  .catch(err => {
    res.status(400).json({error: "Error finding reservation"});
  });
}

async function getById(req, res, next) {
  var id = req.params.id;
  reservationService.getReservationById(id.toUpperCase()).then(results => {
    getReservationCallback(results, res);
  })
  .catch(err => {
    res.status(400).json({error: "Error finding reservation"})
  });
}

async function getByRoom(req, res, next) {
  var room = req.params.room;
  reservationService.getReservationByRoom(room).then(results => {
    getReservationCallback(results, res);
  })
  .catch(err => {
    res.status(400).json({error: "Error finding reservation"})
  });
}

function getReservationCallback(results, res) {
  if(results.length > 0) {
    res.status(200).json(results);
  } else {
    res.status(404).json({error: "No reservations found"});
  }
}


async function getAvailableRooms(req, res, next) {
  var checkin = req.body.checkin;
  var checkout = req.body.checkout;

  var checkinDate = new Date(checkin + " EST");
  var checkoutDate = new Date(checkout + " EST");

  if(dateFns.isPast(checkinDate) && !dateFns.isSameDay(checkinDate, new Date())){
    res.status(400).json({error: "Invalid check-in date"});
    return;
  }

  if(dateFns.isAfter(checkinDate, checkoutDate) || dateFns.isSameDay(checkinDate, checkoutDate)) {
   res.status(400).json({error: "Check-in date must be after check-out date"});
   return;
  }

  availabilityService.getAvailableRoomsForInterval(checkinDate,checkoutDate).then(results => {
    var commonRooms = compareAvailableRoomsCallback(results);

    if(commonRooms.length > 0) {
      res.status(200).json(commonRooms);
    } else {
      res.status(404).json({error: "No rooms found"});
    }
  })
  .catch(err => {
    res.status(400).json({error: err.toString()});
  });
}


// Returns the info for available room types
function compareAvailableRoomsCallback(results) {
  var roomsInfo = results[0];
  var commonRooms = results[1];

  for(var i=2; i < results.length; i++) {
    commonRooms = getCommonItems(commonRooms, results[i]);
  }

  var commonRoomsWithInfo = [];

  commonRooms.forEach(room => {
    roomsInfo.forEach(info => {
      if(info.type_id === room) commonRoomsWithInfo.push(info);
    });
  });

  return commonRoomsWithInfo;
}


// Returns the common items in two string arrays
function getCommonItems(arr1, arr2) {
  var commonItems = [];

  arr1.forEach(item => {
    if(arr2.includes(item)) commonItems.push(item);
  });

  return commonItems;
}
