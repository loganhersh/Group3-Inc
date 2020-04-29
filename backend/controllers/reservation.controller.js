const guestService = require('../services/guest.service');
const reservationService = require('../services/reservation.service');


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

  // TODO: Verify availability


  guestService.createGuest(guest).then(guestId => {
    if(guestId) {
      console.log(guestId);
    } else {
      console.log("Guest could not be created");
    }
  });

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
  reservationService.getAvailableRooms(checkin, checkout).then(results => {
    if(results.length > 0) {
      res.status(200).json(results);
    } else {
      res.status(404).json({error: "No rooms found"});
    }
  })
  .catch(err => {
    res.status(400).json({error: "Error finding rooms"});
  })
}

