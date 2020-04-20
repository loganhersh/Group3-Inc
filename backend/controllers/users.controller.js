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
const authService = require('../services/auth.service');

module.exports = {
  getAllUsers,
  removeUser,
  updatePassword,
  createUser
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

// Updates the users current password
async function updatePassword(req, res, next) {
  const {username, unhashedPassword} = req.body;
  const hashedPassword = authService.hashPassword(unhashedPassword);
  if(hashedPassword) {
    usersService.updatePassword(username, hashedPassword).then(success => {
      success ? res.status(200).json({message: "Password updated"}) :
          res.status(400).json({message: "Password could not be updated"});
    })
    .catch(err => next(err));
  } else {
    res.status(400).json({message:'Bad request: expected data missing'});
  }
}

// TODO: input validation
async function createUser(req, res, next) {
  const {firstname, lastname, username, unhashedPassword, role} = req.body;
  const hashedPassword = authService.hashPassword(unhashedPassword);
  const user = {firstname, lastname, username, hashedPassword, role};

  if(hashedPassword) {
    usersService.insertUser(user).then(success => {
      success ? res.status(200).json({message: "user successfully created"}) :
          res.status(400).json({message: "user could not be created"});
    })
    .catch(err => next(err));
  } else {
    res.status(400).json({message: "Bad request: expected data missting"});
  }
}
