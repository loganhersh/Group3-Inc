// Middleware that "refreshes" user by signing a new JWT
module.exports = function(options) {
  var refreshJwt = function(req, res, next) {
    var jwt = require('jsonwebtoken');
    var config = require('../config.json');
    var payload = {
      sub: req.user.sub,
      permissions: req.user.permissions
    }
    var token = jwt.sign(payload, config.secret, {expiresIn: 60 * 20});
    res.cookie('auth', token, {httpOnly: true, sameSite: true});
    next();
  };

  refreshJwt.unless = require('express-unless');

  return refreshJwt;
}
