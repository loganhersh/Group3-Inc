// Global base urls. All js functions sending http requests should use these urls
const baseAppUrl = 'http://www.myhms.net';
const baseApiUrl = 'http://www.myhms.net:3000';

function sendPostWithCreds(url, payload) {
  var promise = $.ajax({
    method: "POST",
    url: url,
    data: payload,
    dataType: "json",
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).fail(function(data, status, jqXHR) {
    if(data.status === 401) {
      window.location.href = baseAppUrl + '/pages/timeout.html';
    }
  });

  return promise;
}

function sendGetWithCreds(url) {
  var promise = $.ajax({
    method: "GET",
    url: url,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  }).fail(function(data, status, jqXHR) {
    if(data.status === 401) {
      window.location.href = baseAppUrl + '/pages/timeout.html';
    }
  });

  return promise;
}
