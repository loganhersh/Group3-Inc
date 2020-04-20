$(document).ready(function(){
  populateUsersTable();

  $("#inputConfirmChangePassword").keyup(function(event) {
    if(event.key === "Enter") {
      $("#changeSubmit").click();
    }
  });
})

// Show modal event for changePassword
$('#changePasswordModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('#changeUserLabel').text(username);
  setTimeout(function() {
    $('#inputChangePassword').focus();
  },500);

})

$('#changePasswordModal').on('hidden.bs.modal', function(event) {
  $(this).find("input").val('').end();
  $('#confirmPassError').text('');
})

// Show modal event for deleteUser
$('#deleteUserModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('#deleteUserLabel').text(username);
})


// Continuously scrolls to bottom for a fixed period
// Used when the new user component is expanding
function scrollToBottom() {
  var x = 0;
  var task = setInterval(function() {
    if(++x > 30) {
      window.clearInterval(task);
    } else {
      window.scrollTo(0, document.body.scrollHeight);
    }
  }, 10);
}

function showNewUser() {
  $('#new-user-container').removeClass('d-none');
}


//------------------ USERS TABLE POPULATE AND CONFIGURE ------------------------

// Fetches all users and populates the users-table
// Upon failure: displays error
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
    showNewUser();
  }).fail(function(data, status, jqXHR) {
    $('#users-table').hide();
    $('#users-table-error').text("Error loading users. Contact site admin.");
  });
}

// Adds a set of users to the users table
function addUsersToTable(users) {
  var i = 1;
  var usersHtml = '';
  $.each(users, function(key, value) {
    var rowHtml = '<tr>\n';
    rowHtml += '<th scope="row">' + i++ + '</th>\n';
    rowHtml += '<td>' + value.firstname + '</td>\n';
    rowHtml += '<td>' + value.lastname + '</td>\n';
    rowHtml += '<td>' + value.username + '</td>\n';
    rowHtml += '<td>' + value.role + '</td>\n';
    rowHtml += '<td class="text-center">\n';
    rowHtml += '<button class="btn m-0" data-toggle="modal" data-target="#changePasswordModal" data-user="' + value.username + '">\n';
    rowHtml += '<i class="fas fa-user-shield table-button"></i>\n';
    rowHtml += '</button>\n';
    rowHtml += '</td>\n';
    rowHtml += '<td class="text-center">\n';
    rowHtml += '<button class="btn m-0" data-toggle="modal" data-target="#deleteUserModal" data-user="' + value.username + '">\n';
    rowHtml += '<i class="fas fa-user-slash table-button"></i>\n';
    rowHtml += '</button>\n';
    rowHtml += '</td>\n';
    rowHtml += '</tr>\n';

    usersHtml += rowHtml;
  });
  replaceTableData(usersHtml, '#users-table');
  setUsersTableHeight(i-1);
}

// Replaces all tr in the tbody
function replaceTableData(data, tableId) {
  var table = $(tableId);
  table.find("tbody tr").remove();
  table.append(data);
}

// Resizes table, should be used after rows are added
function setUsersTableHeight(rowCount) {
  var x = 80 + 72*rowCount;
  var tableHeight = (x < 600) ? x : 600;
  $('.users-table-scrollbar').height(tableHeight);
}

// ----------------- END USERS TABLE POPULATE AND CONFIGURE -----------------------

// ------------------- DELETE USER FUNCTIONS --------------------------
// Sends API request to delete a specific user
function deleteUser() {
  var username = $('#deleteUserLabel').text();
  var url = "http://localhost:3000/users/delete";
  var payload = {
    username
  }
  sendPostWithCreds(url, payload).done(function(data) {
    // Repopulate table and trigger success alert
    populateUsersTable();
    $('#delete-success-alert-username').text(username);
    triggerAlert('#delete-success-alert');
  })
  .fail(function(data, status, jqXHR) {
    // Trigger failure alert
    triggerAlert('#delete-failure-alert');
  })
}
// ----------------- END DELETE USER FUNCTIONS -----------------------

// ----------------- CHANGE PASSWORD FUNCTIONS -----------------------
function changePassword() {
  var username = $('#changeUserLabel').text();
  var unhashedPassword = $('#inputChangePassword').val();
  var confirmPassword = $('#inputConfirmChangePassword').val();

  if(unhashedPassword === '') {
    $('#confirmPassError').text('Must enter a password');
    return;
  } else if(confirmPassword === '') {
    $('#confirmPassError').text('Must confirm password');
    return;
  } else if(unhashedPassword !== confirmPassword) {
    $('#confirmPassError').text('Passwords do not match');
    return;
  }

  var url = 'http://localhost:3000/users/update';
  var payload = {
    username,
    unhashedPassword
  };

  sendPostWithCreds(url, payload).done(function(data) {
    $('#changePasswordModal').modal('hide');
    $('#change-success-alert-username').text(username);
    triggerAlert('#change-success-alert');
  }).fail(function(data, status) {
    triggerAlert('#change-failure-alert');
  });
}

// ----------------END CHANGE PASSWORD FUNCTIONS ---------------------

// Alert drops in to screen and stops just below nav bar
// Fades after 5 seconds
function triggerAlert(alertId) {
  $(alertId).addClass('show');
  var x = -20;
  setInterval(function() {
    if(x < 140) {
      $(alertId).css('top', x + 'px');
    }
    x += 5;
  }, 2)
  setTimeout(function() {
    $(alertId).removeClass('show');
  }, 4000);
  setTimeout(function() {
    $(alertId).css('top', -80);
  }, 5000);
}
