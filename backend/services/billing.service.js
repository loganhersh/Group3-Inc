/*
    There are several problems I encountered while coding,
    especially when it came to dependencies. When it came
    to the foreign key references, I wasn't sure if I
    should include a query to get the reference, and if
    so, how. I also didn't know if I had to complete
    any mathematical computation here for the invoice charge.
    This is all also styled after the exact same function,
    because I couldn't figure out if all this info would
    be manually inputted or if the info would be
    acquired in other way. More problems identified in
    the comments below.
*/

const db = require('../db/db');

module.exports = {
    createCCPayment,
    createCAPayment,
    chargeInvoice
};

/*function generateChargeID() {
    const invoiceIDQuery = "SELECT invoice_id FROM INVOICE WHERE invoice_id = ?";
    var invoiceID = "";

    return new Promise( (resolve, reject) => {
        db.query(invoiceIDQuery,
            function (error, result, fields) {
                if(error) {
                    console.log(error);
                    reject(error);
                } else {
                    resolve(result.affectedRows > 0);
                    resolve(invoiceID = result);
                }
            });
    });

    const invoiceChargesQuery = "SELECT COUNT()";

}*/

function createCCPayment(payment) {
    // Generates payment when the credit card option is selected
    const query = "INSERT INTO PAYMENT VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    values = [
        payment.payment_id,
        payment.payment_date,
        payment.payment_type,
        payment.payment_amount,
        payment.accountholder_name,
        payment.account_number,
        payment.expiration_month,
        payment.expiration_year,
        payment.card_cvv,
        payment.card_network
    ];

    return new Promise( (resolve, reject) => {
        db.query(query, values,
            function (error, results, fields) {
                if(error) {
                    console.log(error);
                    reject(error);
                } else {
                    resolve(results.affectedRows > 0);
                }
            });
    });
}

function createCAPayment(payment) {
    // Generates payment when the cash option is selected

    const query = "INSERT INTO PAYMENT(payment_id, invoice_id, payment_date, payment_type, " +
        "payment_amount, accountholder_name) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    values = [
        payment.payment_id,
        payment.payment_date,
        payment.payment_type,
        payment.payment_amount,
        payment.accountholder_name,
    ];

    return new Promise( (resolve, reject) => {
        db.query(query, values,
            function (error, results, fields) {
                if(error) {
                    console.log(error);
                    reject(error);
                } else {
                    resolve(results.affectedRows > 0);
                }
            });
    });
}

function chargeInvoice(invoiceCharge) {
    // Creates and invoice charge
    const query = "INSERT INTO INVOICECHARGE VALUES(?, ?, ?, ?, ?)";
    values = [
        invoice.charge_id,
        invoice.invoice_id,
        invoice.date_applied,
        invoice.charge_amount,
        invoice.charge_reason
    ];

    return new Promise( (resolve, reject) => {
        db.query(query, values,
            function (error, results, fields) {
                if(error) {
                    console.log(error);
                    reject(error);
                } else {
                    resolve(results.affectedRows > 0);
                }
            });
    });
}