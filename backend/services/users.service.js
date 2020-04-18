const db = require('../db/db');

module.exports = {
  getUsers
};

function getUsers() {
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
