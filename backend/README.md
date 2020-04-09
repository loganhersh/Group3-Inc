**Backend configuration instructions**<br />

Note: These instructions are for a Windows system<br />

1. Install NodeJS and add it to your system's PATH<br />
2. Install MySQL and add it to your system's PATH<br />
    a. From the MySQL console:<br />
        &nbsp;&nbsp;&nbsp; - run the `create-hms-db.sql` script in the sql folder<br />
        &nbsp;&nbsp;&nbsp; - run the `create-users-table.sql` script in the sql folder<br />
3. In the backend folder:<br />
    a. run '`npm install`' in a terminal<br />
    b. run '`node server.js`' in the terminal. If it worked you should see that the server
    is listening and the database is connected.<br />
<br />

You should now be able to run the `test-demo/index.html` file from a browser. index.html contains 
two buttons to test a couple of API endpoints. "Change Price" currently pulls data from a json, 
but this will be replaced by MySQL data. "Get User" pulls data from the MySQL database.
