/*
  Routes for users.

  To create a new route, use the router object and typically the .post function,
  though not always.

  router.post('remaining/url', handlerMethod)
   - the remaining url in this file would be whatever is after 'localhost:3000/users'

 */
const express = require('express');
const router = express.Router();
const usersController = require('../controllers/users.controller');

// endpoint = 'localhost:3000/users/'
// returns all application users
router.get('/', usersController.getAllUsers);

// endpoint = 'http://localhost:3000/users/remove'
router.post('/delete', usersController.removeUser);

// endpoint = 'http://localhost:3000/users/update'
router.post('/update', usersController.updatePassword);

// endpoint = 'http://localhost:3000/users/create
router.post('/create', usersController.createUser);

module.exports = router;
