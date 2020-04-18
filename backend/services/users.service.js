const db = require('../db/db');

module.exports = {
  getUsers
};

function getUsers() {
  const query = "SELECT * FROM users";
  return new Promise(resolve => {
    db.query(query,
        (error, results) => {
          if(error) {
            console.log(error);
            resolve();
          } else {
            console.log(results.)
            resolve({username: results[0].username, password: results[0].password});
          }
        })
  });
}
