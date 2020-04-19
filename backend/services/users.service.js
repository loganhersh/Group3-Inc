const db = require('../db/db');

module.exports = {
  getAllUsers,
  deleteUser
};

function getAllUsers() {
  const query = "SELECT * FROM users";
  return new Promise(resolve => {
    var userArr = [];
    db.query(query,
        (error, results, fields) => {
          if(error) {
            console.log(error);
            resolve();
          } else {
            results.forEach(row => {
              userArr.push({
                username: row.username,
                password: row.password,
                firstname: row.firstname,
                lastname: row.lastname,
                role: row.role
              });
            });
            resolve(userArr);
          }
        });
  });
}

function deleteUser(username) {
  const query = "DELETE FROM users WHERE username=?";
  return new Promise(resolve => {
    db.query(query, [username],
        function(error, results, fields) {
      if(error) {
        console.log(error);
        resolve();
      } else {
        if(results.affectedRows > 0) {
          resolve(true);
        } else {
          resolve();
        }
      }
    });
  });
}
