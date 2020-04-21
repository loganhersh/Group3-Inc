const db = require('../db/db');

module.exports = {
  getDbStatus
}

function getDbStatus() {
  return new Promise((resolve, reject) => {
    query = "SELECT 'TEST'";
    db.query(query, function(error, results) {
      error ? reject(error) : resolve();
    });
  });
}
