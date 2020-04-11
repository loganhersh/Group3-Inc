const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

// endpoint = 'localhost:3000/auth'
// request body expected to have the json: { "username": "sampleUser", "password": "secret" }
router.post('/', authController.authenticate);

// endpoint = 'localhost:3000/auth/logout'
router.post('/logout', authController.logout);

module.exports = router;
