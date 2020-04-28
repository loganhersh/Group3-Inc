const db = require('../db/db');

const roomtypeTable = "ROOMTYPE";

module.exports = {

};


// Probably unneeded
// function getRoomTypes() {
//   const query = "SELECT ?? FROM ??";
//   const values = ['type_id', roomtypeTable];
//
//   return new Promise((resolve, reject) => {
//     db.query(query, values, (error, results, fields) => {
//       if(error) {
//         console.log(error)
//         reject();
//       } else {
//         var roomTypes = [];
//         results.forEach(type => {
//           roomTypes.push(type.type_id);
//         });
//         resolve(roomTypes);
//       }
//     })
//   })
// }



