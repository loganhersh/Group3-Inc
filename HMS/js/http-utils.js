function sendPostWithCreds(url, payload) {
  return $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).fail(function(data, status, jqXHR) {
    if(jqXHR.status == 401) {
      window.location.href('http://localhost:8080/pages/timeout.html');
    }
  });
}
