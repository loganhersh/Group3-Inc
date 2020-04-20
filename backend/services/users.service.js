const db = require('../db/db');

module.exports = {
  getAllUsers,
  deleteUser,
  updatePassword,
  insertUser
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
        resolve(results.affectedRows > 0);
      }
    });
  });
}

function updatePassword(username, password) {
  const query = "UPDATE users SET password = ? WHERE username = ?";
  return new Promise(resolve => {
    db.query(query, [password, username],
      function(error, results, fields) {
        if(error) {
          console.log(error);
          resolve();
        } else {
          console.log(JSON.stringify(results));
          resolve(results.affectedRows > 0)
        }
      }
    );
  });
}

function insertUser(user) {
  const query = "INSERT INTO users VALUES(?, ?, ?, ?, ?)"
  values = [
      user.username,
      user.hashedPassword,
      user.firstname.toLowerCase(),
      user.lastname.toLowerCase(),
      user.role.toLowerCase()
  ];

  // TODO: add duplicate username handling
  return new Promise(resolve => {
    db.query(query, values,
        function (error, results, fields) {
          if(error) {
            console.log(error);
            resolve();
          } else {
            resolve(results.affectedRows > 0);
          }
        })
  });
}
