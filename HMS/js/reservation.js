
// TODO: prevent booking popup when invalid dates
// TODO: prevent checkout date before check in date


$(document).ready(function () {
  $('.close').on('click', function (event) {
    $('body').removeClass('overlay-open');
  });

  configureDatePickers();
  configureYearSelect();

});

// Adds the next 15 years as expiration options
function configureYearSelect() {
  var date = new Date();
  var year = parseInt(date.getFullYear());

  var html = '<option value="">Year...</option>';
  for(var i=0; i<15; i++) {
    var y = year + i;
    html += '<option value="'+y+'">'+y+'</option>';
  }

  $('#expYear').empty();
  $('#expYear').append(html);
}


// Set up date pickers
function configureDatePickers() {
  var indate = $('#indate');
  var outdate = $('#outdate');

  // on change: hide rooms and prevent choosing a checkout <= checkin
  indate.change(function() {
    hideRooms();
    var dateStr = $(this).val();
    var date;
    date = (dateStr) ? new Date(dateStr) : new Date();
    date.setDate(date.getDate() + 1);
    outdate.attr('min', date.toISOString().slice(0, 10));
  });

  outdate.change(function () {
    hideRooms();
  });

  // Set initial min dates
  var currDate = new Date();
  indate.attr('min', currDate.toISOString().slice(0,10));
  currDate.setDate(currDate.getDate() + 1);
  outdate.attr('min', currDate.toISOString().slice(0,10));
}

// Checks reservation dates
// Returns string if error and empty string otherwise
function checkDates(checkin, checkout) {
  // Check for empty dates
  if(!checkin || !checkout) {
    return "Must select a check-in date and a check-out date";
  }

  // Check that checkin date is before checkout date
  var dateCheckIn = new Date(checkin);
  var dateCheckOut = new Date(checkout);

  var compDate = new Date();
  if(dateCheckIn < compDate && dateCheckIn.toISOString().slice(0,10) !== compDate.toISOString().slice(0,10)) {
    return "Cannot choose check-in date from the past";
  }

  if(dateCheckOut <= dateCheckIn) {
    return "Check-in date must be before check-out date";
  }

  return "";
}


// gets available rooms and displays them
function showRooms() {
  var checkin = $('#indate').val();
  var checkout = $('#outdate').val();

  var err = checkDates(checkin, checkout);
  if(err) {
    showErrorModal(err);
    return;
  }

  getAvailableRooms();
  $('#rooms').removeClass("d-none");
}


// Shows the error modal with the provided message
function showErrorModal(text) {
  $('#error-modal-text').text(text);
  $('#error-modal').modal('show');
}


// populates data in the booking popup
function configureAndShowBookingPopup(roomtypeId) {

  var indateStr = $('#indate').val();
  var outdateStr = $('#outdate').val();
  var err = checkDates(indateStr, outdateStr);
  if(err){
    showErrorModal(err);
    hideRooms();
    return;
  }

  // prevent scroll on body
  $('body').addClass('overlay-open');

  // get room info and set room name
  var roomtype = JSON.parse(window.localStorage.getItem(roomtypeId));
  $('#roomtype').text(roomtype.type_name);

  // Set popup dates
  $('#checkin').text(indateStr);
  $('#checkout').text(outdateStr);

  // Set popup num adults and children
  $('#num-adult').text($('#adult').val());
  $('#num-child').text($('#child').val());

  var indate = new Date(indateStr);
  var outdate = new Date(outdateStr);
  var numdays = (outdate.getTime() - indate.getTime()) / (24*60*60*1000);
  var price = (numdays*roomtype.type_base_price).toFixed(2);
  var totalWithTax = (price * 1.06625).toFixed(2);

  // display pricing info
  $('#num-nights').text(numdays);
  $('#price').text(price);
  $('#total').text(totalWithTax);

  // display appropriate photo
  $('#room-photo').attr('src', roomtype.image_path);

  window.localStorage.setItem('currType', roomtypeId);
  window.localStorage.setItem('currDates', JSON.stringify({in:indateStr, out:outdateStr}));
}


function hideRooms() {
  $('#rooms').addClass('d-none');
}


// gets available rooms from the backend
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

// generates and appends the html for each avialable room type
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


// generates the html to display a single room type
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


function bookRoom() {
  var guest = getGuestInfo();
  var payment = getPaymentInfo();
  var err = validateBooking(guest, payment);
  if(err) {
    showErrorModal(err);
    return;
  }
  showErrorModal("All input valid");
}

function getGuestInfo() {
  var guest = {};
  guest.firstname = $('#firstname').val();
  guest.lastname = $('#lastname').val();
  guest.email = $('#email');
  guest.phone = $('#phone');
  guest.address = {};
  guest.address.street = $('#street');
  guest.address.city = $('#city');
  guest.address.state = $('#state');
  guest.address.zip = $('#zip');

  return guest;
}


function getPaymentInfo() {
  var payment = {};
  payment.method = $('#paymentMethod').val();
  if(payment.method === 'CC') {
    payment.credit.type = $('#cardType').val();
    payment.credit.number = $('#accountNum').val();
    payment.credit.name = $('#accountHolder').val();
    payment.credit.exp.month = $('#expMonth').val();
    payment.credit.exp.year = $('#expYear').val();
  }

  return payment;
}


function validateBooking(guest, payment) {
  var err = '';
  var missingArr = [];
  var invalidArr = [];

  if(!guest.firstname) missingArr.push('First name');
  if(!guest.lastname) missingArr.push('Last name');
  if(!guest.email) missingArr.push('Email');
  if(!guest.address.street) missingArr.push('Address - Street');
  if(!guest.address.city) missingArr.push('Address - City');
  if(!guest.address.state) missingArr.push('Address - State');
  if(!guest.address.zip) missingArr.push('Address - Zip');

  if(!payment.method) missingArr.push('Payment method');
  if(payment.method === 'CC') {
    if(!payment.credit.type) missingArr.push('Card type');
    if(!payment.credit.number) missingArr.push('Card number');
    if(!payment.credit.name) missingArr.push('Name on card');
    if(!payment.credit.exp.month) missingArr.push('Card expiration month');
    if(!payment.credit.exp.year) missingArr.push('Card expiration year');
  }

  if(missingArr.length > 0) {
    err += "Missing items:\n";
    missingArr.forEach(item => {
      err += "\t"+item+"\n";
    });
  }

  return err;
}


function getState(state) {
  var states = {"AL": "Alabama", "AK": "Alaska","AS": "American Samoa", "AZ": "Arizona",
    "AR": "Arkansas","CA": "California","CO": "Colorado","CT": "Connecticut",
    "DE": "Delaware","DC": "District Of Columbia","FM": "Federated States Of Micronesia",
    "FL": "Florida","GA": "Georgia","GU": "Guam","HI": "Hawaii","ID": "Idaho","IL": "Illinois",
    "IN": "Indiana","IA": "Iowa","KS": "Kansas","KY": "Kentucky","LA": "Louisiana",
    "ME": "Maine","MH": "Marshall Islands","MD": "Maryland","MA": "Massachusetts",
    "MI": "Michigan","MN": "Minnesota","MS": "Mississippi","MO": "Missouri","MT": "Montana",
    "NE": "Nebraska","NV": "Nevada","NH": "New Hampshire","NJ": "New Jersey",
    "NM": "New Mexico","NY": "New York","NC": "North Carolina","ND": "North Dakota",
    "MP": "Northern Mariana Islands","OH": "Ohio","OK": "Oklahoma","OR": "Oregon",
    "PW": "Palau","PA": "Pennsylvania","PR": "Puerto Rico","RI": "Rhode Island",
    "SC": "South Carolina","SD": "South Dakota","TN": "Tennessee","TX": "Texas",
    "UT": "Utah","VT": "Vermont","VI": "Virgin Islands","VA": "Virginia","WA": "Washington",
    "WV": "West Virginia","WI": "Wisconsin","WY": "Wyoming"
  };

  if(states['state']) {
    return state.toUpperCase();
  }

  Object.keys(states).forEach((key) => {
    if(states[key] === state.toUpperCase()) {
      return key;
    }
  });

  return "";
}
