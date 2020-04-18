$(document).ready(function(){
  populateUsersTable();
})

$('#changePasswordModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('.modal-title').text('Change Password for ' + username);
})

$('#deleteUserModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('.modal-title').text('Delete user: ' + username + '?');
})

function scrollToBottom() {
  var x = 0;
  var task = setInterval(function() {
    if(++x > 240) {
      window.clearInterval(task);
    } else {
      window.scrollTo(0, document.body.scrollHeight);
    }
  }, 10);
}


function populateUsersTable() {
  var url = "http://localhost:3000/users";
  $.ajax({
    method: "GET",
    url: url,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    addUsersToTable(data);
  }).fail(function(data, status, jqXHR) {
    $('#users-table').hide();
    $('#users-table-error').text("Error loading users. Contact site admin.");
  });
}


function addUsersToTable(users) {
  var tbody = $('#users-table-body');
  $.each(users, function(key, value) {
    console.log(value.username + " " + value.role);
  });
}
