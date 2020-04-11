/*
  Compiles all routes files to simplify the server.js file.
  For new types of routes, create a new file like the others and then add
  a 'require()' statement and add the routes variable to the exports.
 */

const authRoutes = require('./auth.routes')
const roomsRoutes = require('./rooms.routes');
const usersRoutes = require('./users.routes');

module.exports = {
  authRoutes,
  roomsRoutes,
  usersRoutes
};



