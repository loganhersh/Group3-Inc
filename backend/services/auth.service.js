const config = require('../config.json');
const jwt = require('jsonwebtoken');
const db = require('../db/db');

module.exports = {
  authenticate,
  verify
};

// Verifies the provided username and password match a user in the database and resolves
// with a new JWT
function authenticate(username, password) {
  const query = "SELECT username FROM users WHERE username=? AND password=?"
  const values = [username, password];
  return new Promise(resolve => {
    db.query(query, values,
        (error, results) => {
          if(error) {
            console.log(error);
          } else {
            user = results[0];
            if(user) {
              const token = getToken(user.username);
              resolve ({ username: user.username, token: token });
            } else {
              resolve ();
            }
          }
        });
  });
}

// Verifies a user with the provided username and password exists in the database
function verify(username, password) {
  const query = "SELECT username FROM users WHERE username=? AND password=?"
  const values = [username, password];
  return new Promise( resolve => {
    db.query(query, values,
        (error, results) => {
          if (error) {
            console.log(error);
          } else {
            resolve(results.length > 0);
          }
        });
  });
}

// Returns a new JWT with a 30 minute expiration
function getToken(username) {
  return jwt.sign({sub: username}, config.secret, {expiresIn: 60 * 30});
}
