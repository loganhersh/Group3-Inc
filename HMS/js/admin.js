function test() {
  url = "http://localhost:3000/users";
  const username = window.localStorage.getItem('username');
  payload = { user: username };

  $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).done(function (data, status, jqXHR) {
    $("#test-output").text("API sent: " + JSON.stringify(data));
  }).fail(function(data, status, jqXHR) {
    $("#test-output").text("API blocked request");
  });
}
