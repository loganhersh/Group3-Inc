$(document).ready(function() {
  getDbStatus();
})

function getDbStatus() {
  var url = baseApiUrl + '/admin/db';
  var dbStatus = $('#db-status');
  dbStatus.css('min-width',dbStatus.width());
  dbStatus.text('');

  sendGetWithCreds(url).done( function(data, status) {
    console.log(data);
    dbStatus.text(data.state);
    var color = (data.state === 'Connected') ? '#05b600' : '#D00000';
    dbStatus.css('color',color);
  })
  .fail(function(data, status) {
    dbStatus.text('Error');
    dbStatus.css('color','#D00000')
  });
}

// TODO: get users status (num admins, num regular users)


