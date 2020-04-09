/*
    This would be where a mysql connection would be made and exported to allow
    services to make queries. See 'db.js'

    Until the database is set up, we can just use sample data in JSON format.
 */
const roomData = require('./sampleRoomData');

module.exports = roomData.rooms;

