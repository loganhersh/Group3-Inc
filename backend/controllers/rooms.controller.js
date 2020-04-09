/*
  This is where the http requests for rooms get routed.
  The controller deconstructs the request body and takes the appropriate action
  for the request, then returns the appropriate response.

  Functions that receive http requests must be async.

  The appropriate services are used to query databases or perform other actions.
  'res' is the response object, you can set the status code that you want and then
  use .json to send a json payload with the response.

  Services will typically return a Promise object. If you want an async function to
  wait for the Promise to resolve before continuing, use the 'await' keyword.

  Any function you want publicly available for other files that 'require()' this file,
  the function name must be in the module.exports statement.
 */
const roomsService = require('../services/rooms.service');

module.exports = {
  changeBasePrice
};

async function changeBasePrice(req, res, next) {
  const {roomId,price} = req.body;
  roomsService.changeBasePrice(roomId, price).then(success => {
    success ? res.json(success) : res.status(404).json({message: "Room could not be found"});
  })
  .catch(err => next(err));
}
