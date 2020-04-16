var jwt = require('jsonwebtoken');
var config = require('./config.json');

module.exports = {
  loggedInRedirect
};

function loggedInRedirect(req, res, next) {
  // Redirect to home page if valid token exists
  token = req.cookies.auth;
  try {
    jwt.verify(token, config.secret);
    res.redirect('/pages/home.html');
  } catch(err) {
    next();
  }
}
