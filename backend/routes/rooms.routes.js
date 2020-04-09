/*
  Routes for rooms.

  To create a new route, use the router object and typically the .post function,
  though not always.

  router.post('remaining/url', handlerMethod)
   - the remaining url in this file would be whatever is after 'localhost:3000/rooms'

 */
const express = require('express');
const router = express.Router();
const roomsController = require('../controllers/rooms.controller');

// endpoint = 'localhost:3000/rooms/price'
// request body expected to have the json: { "roomId": 000, "price": 000 }
router.post('/price', roomsController.changeBasePrice);

module.exports = router;
