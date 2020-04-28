const guestService = require('../services/guest.service');


module.exports = {
  createReservation
};


async function createReservation(req, res, next) {
  var reservation = req.body.reservation;
  var guest = req.body.guest;

  // TODO: Verify availability


  // TODO: Create guest (MySQL autoincrement? or use email)
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



// Returns json of all users (no passwords)
async function getAllUsers(req, res, next) {
  usersService.getAllUsers().then(userArr => {
    userArr ? res.json(userArr) :
        res.status(404).json({message: "No users were found"});
  })
  .catch(err => next(err));
}
