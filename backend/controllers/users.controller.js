/*
  This is where the http requests for users get routed.
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
const usersService = require('../services/users.service');

module.exports = {
  getUsers
};

async function getUsers(req, res, next) {
  usersService.getUsers().then(data => {
    data ? res.json(data) :
        res.status(404).json({message: "User could not be found"});
  })
  .catch(err => next(err));
}
