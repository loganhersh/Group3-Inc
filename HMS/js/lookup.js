function searchByGuest(){
    // Get the value of the of the last name text box
    var searchedName = document.getElementById("lname").value;
    
    // Concatinating the string
    var searchURL = baseApiUrl + "/reservation/name/" + searchedName;

    // Performing http request
    sendGetWithCreds(searchURL);
}

function searchByRoom(){
    // Get the value of the room number selected in the dropdown
    var searchedRoom = document.getElementById("rooms").value;

    // Concatinating the string
    var searchURL = baseApiUrl + "/reservation/room/" + searchedRoom;

    // Performing http request
    sendGetWithCreds(searchURL);
}

function searchById(){
    // Get the value of the room number selected in the dropdown
    var searchedId = document.getElementById("idNumber").value;

    // Concatinating the string
    var searchURL = baseApiUrl + "/reservation/id/" + searchedId;

    // Performing http request
    sendGetWithCreds(searchURL);
}