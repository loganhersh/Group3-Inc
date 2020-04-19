function sendPostWithCreds(url, payload) {
  return $.ajax({
    method: "POST",
    url: url,
    data: payload,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  });
}
