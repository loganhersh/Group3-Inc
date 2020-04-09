const db = require('../db/db');

module.exports = {
  getUser
};

function getUser(user) {
  const query = "SELECT * FROM users WHERE username='" + user + "'";
  return new Promise(resolve => {
    db.query(query,
        (error, results) => {
          if(error) {
            console.log(error);
            resolve();
          } else {
            resolve({username: results[0].username, password: results[0].password});
          }
        })
  });
}
