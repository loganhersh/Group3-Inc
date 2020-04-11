/*
  This is the backend server.
  All http requests come in and go through all the middleware before being routed
  to the proper endpoint.
 */
var express = require('express');
var cors = require('cors');
var parser = require('body-parser');
var cookieParser = require('cookie-parser');
var jwt = require('express-jwt');
var config = require('./config.json')
var routes = require('./routes');

// Create the server
var app = express()
.use(cors({
  origin: true,
  optionsSuccessStatus: 200,
  credentials: true
}))                                             // middleware
.use(parser.urlencoded({extended: false}))      // middleware
.use(parser.json())                             // middleware
.use(cookieParser())                            // adds req.cookies
.use(jwt({                              // verifies valid jwt if protected route
      secret: config.secret,
      credentialsRequired: true,
      getToken: function(req) {
        if(req.cookies.auth) {
          return req.cookies.auth;
        } else {
          return null;
        }
      } }).unless({ path: ['/auth','/users/new']}),  // don't require auth when logging in or creating user
    function(err, req, res, next) {
      // invalid or no jwt, deny access
      if(err.name === 'UnauthorizedError') {
        res.status(401).send(err.message);
      }
    })
.use('/auth', routes.authRoutes)                // routing
.use('/rooms', routes.roomsRoutes)              // routing
.use('/users', routes.usersRoutes);             // routing


//  Listens for all http requests to 'localhost:3000/'
app.listen(3000, function() {
  console.log('Server listening on port 3000');
});

module.exports = app;
