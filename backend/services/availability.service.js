const addDays = require('date-fns/addDays');
const roomService = require('./rooms.service');
const db = require('../db/db');


module.exports = {

};



// Citation: https://stackoverflow.com/questions/8619879/javascript-calculate-the-day-of-the-year-1-366
// Answer by Joe Orost

Date.prototype.isLeapYear = function() {
  const year = this.getFullYear();
  if((year & 3) != 0){
    return false;
  }
  return ((year % 100) != 0 || (year % 400) == 0);
};

Date.prototype.getJulianDate = function() {
  var days = [0,31,59,90,120,151,181,212,243,273,304,334];
  var month = this.getMonth();
  var date = this.getDate();
  var julianDate = days[month] + date;
  if(month > 1 && this.isLeapYear()) julianDate++;
  return julianDate;
}
