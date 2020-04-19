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
  getAllUsers,
  removeUser
};

// Returns json of all users (no passwords)
async function getAllUsers(req, res, next) {
  usersService.getAllUsers().then(userArr => {
    userArr ? res.json(userArr) :
        res.status(404).json({message: "No users were found"});
  })
  .catch(err => next(err));
}

// Removes the user with the provided username
async function removeUser(req, res, next) {
  const {username} = req.body;
  usersService.deleteUser(username).then(success => {
    success ? res.status(200).json({message: "User " + username + " deleted"}) :
        res.status(400).json({message: "Error deleting user"});
  })
  .catch(err => next(err));
}
