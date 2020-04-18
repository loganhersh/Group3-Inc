const db = require('../db/db');

module.exports = {
  getUsers
};

function getUsers() {
  const query = "SELECT * FROM users";
  return new Promise(resolve => {
    db.query(query,
        (error, results, fields) => {
          if(error) {
            console.log(error);
            resolve();
          } else {
            results.forEach(row => {
              console.log(row);
            });
            resolve({ success: true });
          }
        })
  });
}
