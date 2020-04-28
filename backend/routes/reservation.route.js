const express = require('express');
const router = express.Router();
const reservationController = require('../controllers/reservation.controller');

router.post('/', reservationController.createReservation);

/**
 * @api {get} /reservation/id/:id
 * @apiName Get Reservation By ID
 * @apiPermission User
 * @apiGroup reservation
 *
 * @apiParam {String} [id] Reservation ID
 *
 * @apiSuccess (200) {Array} [] Array of reservations in JSON format
 * @apiFailure (404) {String} [error] Reservation not found error
 * @apiFailure (400) {String} [error] Generic error message
 */
router.get('/id/:id', reservationController.getById);

/**
 * @api {get} /reservation/name/:name
 * @apiName Get Reservation By Guest Last Name
 * @apiPermission User
 * @apiGroup reservation
 *
 * @apiParam {String} [name] Guest last name
 *
 * @apiSuccess (200) {Array} [] Array of reservations in JSON format
 * @apiFailure (404) {String} [error] Reservation not found error
 * @apiFailure (400) {String} [error] Generic error message
 */
router.get('/name/:name', reservationController.getByName);

/**
 * @api {get} /reservation/room/:room
 * @apiName Get Reservation By Room Number
 * @apiPermission User
 * @apiGroup reservation
 *
 * @apiParam {Integer} [room] Reservation Room Number
 *
 * @apiSuccess (200) {Array} [] Array of reservations in JSON format
 * @apiFailure (404) {String} [error] Reservation not found error
 * @apiFailure (400) {String} [error] Generic error message
 */
router.get('/room/:room', reservationController.getByRoom);

module.exports = router;
