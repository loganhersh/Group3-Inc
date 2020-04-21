$(document).ready(function() {
  getDbStatus();
  getUsersStatus();
});

// Gets current status of mysql database
function getDbStatus() {
  var url = baseApiUrl + '/admin/db';
  var dbStatus = $('#db-status');
  dbStatus.css('min-width',dbStatus.width());
  dbStatus.text('');

  sendGetWithCreds(url).done( function(data, status) {
    dbStatus.text(data.state);
    var color = (data.state === 'Connected') ? '#05b600' : '#D00000';
    dbStatus.css('color',color);
  })
  .fail(function(data, status) {
    dbStatus.text('Error');
    dbStatus.css('color','#D00000')
  });
}

// Gets total users, num admins, and num users
function getUsersStatus() {
  var url = baseApiUrl + '/users/status';
  sendGetWithCreds(url).done(function(data, status) {
    $('#users-total').text(data.total);
    $('#users-admins').text(data.admins);
    $('#users-users').text(data.users);
  })
  .fail(function(data, status) {
    $('#user-total').text('-');
    $('#users-admins').text('-');
    $('#users-users').text('-');
  });
}

