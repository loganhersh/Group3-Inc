$(document).ready(function(){
  populateUsersTable();
})

// Show modal event for changePassword
$('#changePasswordModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('.modal-title').text('Change Password for ' + username);
})

// Show modal event for deleteUser
$('#deleteUserModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var username = button.data('user');
  var modal = $(this);
  modal.find('.modal-title').text('Delete user: ' + username + '?');
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
  setTableHeight(i-1);
}

// Replaces all tr in the tbody
function replaceTableData(data, tableId) {
  var table = $(tableId);
  table.find("tbody tr").remove();
  table.append(data);
}

// Resizes table, should be used after rows are added
function setTableHeight(rowCount) {
  var x = 80 + 72*rowCount;
  var tableHeight = (x < 600) ? x : 600;
  $('.users-table-scrollbar').height(tableHeight);
}

function showNewUser() {
  $('#new-user-container').removeClass('d-none');
}
