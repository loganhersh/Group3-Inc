/*
  This is the backend server.
  All http requests come in and go through all the middleware before being routed
  to the proper endpoint.
 */
var express = require('express');
var cors = require('cors');
var parser = require('body-parser');
var cookieParser = require('cookie-parser');
var expressjwt = require('express-jwt');
var jwt = require('jsonwebtoken');
var config = require('./backend/config.json')
var routes = require('./backend/routes');

// Create the servers
var app = express();
var api = express();

var appPort = 8080;
var apiPort = 3000;

var excludedPaths = [/\S*\.css/,/photos\/\S*/,/js\/\S*/];

/////////////////////////// Configure App \\\\\\\\\\\\\\\\\\\\\\\\\
app.use(cors({
  origin: true,
  optionsSuccessStatus: 200,
  credentials: true
}))
.use(parser.urlencoded({extended: false}))
.use(parser.json())
.use(cookieParser())
.use(/\S*\/login.html/, function(req, res, next) {
  // Redirect to home page if valid token exists
  token = req.cookies.auth;
  try {
    jwt.verify(token, config.secret);
    res.redirect('/pages/home.html');
  } catch(err) {
    next();
  }
})
.use(expressjwt({
      secret: config.secret,
      credentialsRequired: true,
      getToken: function(req) {
        if(req.cookies.auth) {
          return req.cookies.auth;
        } else {
          return null;
        }
      } }).unless({ path: [/\S*\/login.html/,/\S*\.css/,/photos\/\S*/,/js\/\S*/]}),
    function(err, req, res, next) {
      // invalid or no jwt, deny access
      if(err.name === 'UnauthorizedError') {
        res.redirect('/pages/login.html');
      }
      // TODO: Implement handling of expired tokens
    })
.use(express.static('HMS'));


///////////////////////// Configure API \\\\\\\\\\\\\\\\\\\\\\\\\\\
api.use(cors({
  origin: true,
  optionsSuccessStatus: 200,
  credentials: true
}))
.use(parser.urlencoded({extended: false}))
.use(parser.json())
.use(cookieParser())
.use(expressjwt({
      secret: config.secret,
      credentialsRequired: true,
      getToken: function(req) {
        if(req.cookies.auth) {
          return req.cookies.auth;
        } else {
          return null;
        }
      } }).unless({ path: ['/auth','/users/new']}),
    function(err, req, res, next) {
      // invalid or no jwt, deny access
      if(err.name === 'UnauthorizedError') {
        res.status(401).send(err.message);
      }
    })
.use('/auth', routes.authRoutes)
.use('/rooms', routes.roomsRoutes)
.use('/users', routes.usersRoutes)

//  Listens for all http requests to 'localhost:8080/'
app.listen(appPort, function() {
  console.log('Server listening on port ' + appPort);
});

// Listens for all http requests to 'localhost:3000/'
api.listen(apiPort, function() {
  console.log('API listening on port '+ apiPort);
});

module.exports = {
  app,
  api
};
