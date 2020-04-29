
$(document).ready(function() {
  checkAdmin();

  searchByRoom();

});

// Displays admin tab if admin and adjusts container width
function checkAdmin() {
  var admin = window.localStorage.getItem('ad-auth');
  var maxWidth = '800px';
  if(admin === 'true') {
    $('#admin-tab').removeClass('d-none');
    maxWidth = '1000px';
  }
  $('#home-container').css('max-width',maxWidth);
}


function searchByRoom(){
  // Get the value of the room number selected in the dropdown
  // var searchedRoom = document.getElementById("rooms").value;    // Hardcoding this for troubleshooting
  searchedRoom = "348";    // Concatinating the string
  var searchURL = baseApiUrl + "/reservation/room/" + searchedRoom;    // Preforming http request
  sendGetWithCreds(searchURL);
}
