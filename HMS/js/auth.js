const baseApiUrl = "http://localhost:3000";
const baseAppUrl = "http://localhost:8080";

function auth() {
  const url = baseApiUrl + "/auth";
  username = document.getElementById("username").value;
  password = document.getElementById("password").value;
  const payload = {
    username,
    password
  }
  sendAuthRequest(url,payload);
}

function logout() {
  const url = baseApiUrl + "/auth/logout";
  $.ajax({
    method: "POST",
    url: url,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    window.location.replace(baseAppUrl + '/pages/login.html');
  }).fail(function(data, status, jqXHR) {
    alert(JSON.stringify(data.responseJSON.message));
  })
}

function sendAuthRequest(url, payload) {
  $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    window.location.replace(baseAppUrl + '/pages/home.html');
  }).fail(function(data, status, jqXHR) {
    alert(JSON.stringify(data.responseJSON.message));
  });
}
