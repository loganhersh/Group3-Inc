const db = require('../db/db');

const userTable = "USER";

module.exports = {
  getAllUsers,
  deleteUser,
  updatePassword,
  insertUser,
  getStatus
};

function getAllUsers() {
  const query = "SELECT * FROM ??";
  return new Promise(resolve => {
    var userArr = [];
    db.query(query, [userTable],
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
  const query = "DELETE FROM ?? WHERE username=?";
  return new Promise(resolve => {
    db.query(query, [userTable, username],
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
  const query = "UPDATE ?? SET password = ? WHERE username = ?";
  return new Promise(resolve => {
    db.query(query, [userTable, password, username],
      function(error, results, fields) {
        if(error) {
          console.log(error);
          resolve();
        } else {
          resolve(results.affectedRows > 0)
        }
      }
    );
  });
}

function insertUser(user) {
  const query = "INSERT INTO ?? VALUES(?, ?, ?, ?, ?)";
  values = [
      userTable,
      user.username,
      user.hashedPassword,
      user.firstname.toLowerCase(),
      user.lastname.toLowerCase(),
      user.role.toLowerCase()
  ];

  return new Promise((resolve, reject) => {
    db.query(query, values,
        function (error, results, fields) {
          if(error) {
            console.log(error);
            reject(error);
          } else {
            resolve(results.affectedRows > 0);
          }
        });
  });
}

function getStatus() {
  const query = "SELECT ( SELECT COUNT(username) FROM ?? ) as total,"
      + "( SELECT COUNT(role) FROM ?? WHERE role='admin' ) as admins,"
      + "( SELECT COUNT(role) FROM ?? WHERE role='user' ) as users";
  return new Promise((resolve, reject) => {
    db.query(query, [userTable, userTable, userTable],
        function (error, results) {
      if (error) {
        console.log(error);
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
}
