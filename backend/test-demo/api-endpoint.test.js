/*
  This demo sends an http request to change the base price of a room.
  It assumes that the backend server is up and running on port 3000 of the localhost.
*/
let baseUrl = "http://localhost:3000/";

function changePrice() {
  const url = baseUrl + "rooms/price";
  let payload = {
    "roomId": 101,
    "price": 100
  };
  sendRequest(url, payload);
}

function getUser() {
  const url = baseUrl + "users";
  let payload = {"user":"admin"};
  sendAuthRequest2(url, payload, callbackGetUser);
}

function callbackGetUser(data, status, jqXHR) {
  alert("Status " + data.status + ": " + data.statusText);
}

function sendRequest(url, payload) {
  $.post(url, payload)
  .done(function (data, status, jqXHR) {
    alert(JSON.stringify(data));
  }).fail(function() {
    alert("Failed");
  });
}

function sendAuthRequest2(url, payload, callback=null) {
  $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    alert(JSON.stringify(data));
  }).fail(function(data, status, jqXHR) {
    if(callback) {
      callback(data, status, jqXHR);
    } else {
      alert(JSON.stringify(data.responseJSON.message));
    }
  });
}
