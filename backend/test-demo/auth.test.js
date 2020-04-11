
function auth() {
  const url = "http://localhost:3000/auth";
  username = document.getElementById("username").value;
  password = document.getElementById("password").value;
  const payload = {
    username,
    password
  }
  sendAuthRequest1(url,payload, function(data) {
    alert(data + " successfully logged in");
  });
}

function logout() {
  const url = "http://localhost:3000/auth/logout";
  sendAuthRequest1(url, null, () => alert("you have logged out"));
}

// function sendAuthRequest(url, payload) {
//   $.post(url, payload)
//   .done(function (data, status, jqXHR) {
//     alert(JSON.stringify(data));
//   }).fail(function(data, status, jqXHR) {
//     alert(JSON.stringify(data.responseJSON.message));
//   });
// }

function sendAuthRequest1(url, payload, callback=null) {
  $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    if(callback) {
      callback(data, status, jqXHR);
    } else {
      alert(JSON.stringify(data));
    }
  }).fail(function(data, status, jqXHR) {
    alert(JSON.stringify(data.responseJSON.message));
  });
}
