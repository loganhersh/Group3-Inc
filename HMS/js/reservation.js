
$(document).ready(function () {
  $('.close').on('click', function (event) {
    $('body').removeClass('overlay-open');
  });


});

function showRooms() {
  getAvailableRooms();
  $('#rooms').removeClass("d-none");
}

function bookRoomClick() {











}



function configureAndShowBookingPopup(roomtypeId) {
  $('body').addClass('overlay-open');
  var roomtype = JSON.parse(window.localStorage.getItem(roomtypeId));
  $('#roomtype').text(roomtype.type_name);

  // Set popup dates
  var indateStr = $('#indate').val();
  var outdateStr = $('#outdate').val();
  $('#checkin').text(indateStr);
  $('#checkout').text(outdateStr);

  $('#num-adult').text($('#adult').val());
  $('#num-child').text($('#child').val());

  var indate = new Date(indateStr);
  var outdate = new Date(outdateStr);
  var numdays = (outdate.getTime() - indate.getTime()) / (24*60*60*1000);
  var price = (numdays*79.99).toFixed(2);
  var totalWithTax = (price * 1.06625).toFixed(2);

  $('#num-nights').text(numdays);
  $('#price').text(price);
  $('#total').text(totalWithTax);

}


function getAvailableRooms() {
  var url = baseApiUrl + '/reservation/rooms';
  var payload = {
    checkin: '2020-04-30',
    checkout: '2020-05-03'
  }
  sendPostWithCreds(url, payload).done((data, status, jqXHR)=>{
    buildRoomRows(data);
  })
}

function buildRoomRows(rooms) {
  var roomsContainer = $('#rooms');
  var html = '';

  rooms.forEach(room => {
    html += buildRoomRow(room);
    window.localStorage.setItem(room.type_id, JSON.stringify(room));
  });

  roomsContainer.empty();
  roomsContainer.append(html);
  $('.bookButton').on('click', function(event) {
    configureAndShowBookingPopup($(this).attr('value'));
  });
}

function buildRoomRow(room) {
  rowHtml = "<div class='row my-4' id='"+room.type_id+"'>"
      + "<div class='col-md-4'>"
      + "<img src='"+room.image_path+"' class='img-responsive' style='width:100%;'>"
      + "</div>"
      + "<div class='col-md-4'>"
      + "<h2>"+room.type_name+"</h2>"
      + "<h6><i class='fas fa-smoking-ban' style='font-size:20px;color:#D00000;'></i>NON-SMOKING</h6>"
      + "<h5><i class='fas fa-bed'></i> Bed Count: "+room.type_num_beds+"</h5>"
      + "<h5><i class='fas fa-user-friends'></i> Max Occupancy: "+room.type_max_occupancy+"</h5>"
      + "</div>"
      + "<div class='col-md-4 rates'>"
      + "<h6>(USD-$)</h6>"
      + "<h6>Nightly rate excluding tax</h6>"
      + "<h4>"+room.type_base_price+"</h4>"
      + "<a href='#bookRoom'><button class='king-button bookButton' value='"+room.type_id+"'>BOOK NOW</button></a>"
      + "</div>"
      + "</div>"
      + "<hr>";
  return rowHtml;
}
