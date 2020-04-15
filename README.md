# Group$-Inc
Reservation / Billing Application

**Setup instructions**<br />

1. Install NodeJS and add it to your system's PATH<br />
2. Install MySQL and add it to your system's PATH<br />
    a. From the MySQL console:<br />
        &nbsp;&nbsp;&nbsp; - run the `create-hms-db.sql` script in the backend/sql folder<br />
        &nbsp;&nbsp;&nbsp; - run the `create-users-table.sql` script in the backend/sql folder<br />
3. In the project root directory:<br />
    a. run '`npm install`' in a terminal<br />
    b. run '`node server.js`' in the terminal. If it worked you should see that the servers
    are listening and the database is connected.<br />
<br />

You should now be able to go to `localhost:8080` from a browser. The only current valid login is 
username: 'admin', password: 'password'.  
