function sendEmail(recieverEmail, receiptInfo){
    //Import nodemailer
    var nodemailer = require('nodemailer');

    // Create transporter authenticated with our group gmail account
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            // Authentication email
            user: 'Group3inccmsc495@gmail.com',
            // Authentication password
            pass: 'askelhnbzm'
        }
    });
    
    // Fill in emails from, to, subject, and body
    var mailOptions = {
        from: 'Group3inccmsc495@gmail.com',
        to: recieverEmail,
        subject: 'Sending Email using Node.js. This is your receipt',
        text: receiptInfo
    };
    
    // Send the email from our transporter
    transporter.sendMail(mailOptions, function(error, info){
        // Error handling
        if (error) {
            console.log(error);
        } else {
            console.log('Email sent: ' + info.response);
        }
    });
}

// This function will bring up the print preview screen and print the entire window
function printOptions(){
    window.print()
}
