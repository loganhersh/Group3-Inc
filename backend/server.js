/*
  This is the backend server.
  All http requests come in and go through all the middleware before being routed
  to the proper endpoint.
 */
var express = require('express');
var cors = require('cors');
var parser = require('body-parser');
var routes = require('./routes');

// Create the server
var app = express()
.use(cors())                                    // middleware
.use(parser.urlencoded({extended: false}))      // middleware
.use(parser.json())                             // middleware
.use('/rooms', routes.roomsRoutes)              // routing
.use('/users', routes.usersRoutes);             // routing


//  Listens for all http requests to 'localhost:3000/'
app.listen(3000, function() {
  console.log('Server listening on port 3000');
});

module.exports = app;
