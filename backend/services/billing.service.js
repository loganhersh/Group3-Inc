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

const invoiceTable = "INVOICE";
const paymentTable = "PAYMENT";
const invoiceChargeTable = "INVOICECHARGE";

module.exports = {
    generateInvoice,
    createPayment,
    chargeInvoice
};

function createCCPayment(payment) {
    const query = "INSERT INTO ?? VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // invoice_id skipped
    values = [
        paymentTable,
        payment.payment_id,
        payment.payment_date,
        payment.payment_type,
        payment.payment_amount,
        payment.accountholder_id,
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
    const query = "INSERT INTO ?? VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // invoice_id skipped
    values = [
        paymentTable,
        payment.payment_id,
        payment.payment_date,
        payment.payment_type,
        payment.payment_amount,
        payment.accountholder_id,
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

function chargeInvoice(invoiceCharge) {
    const query = "INSERT INTO ?? VALUES(?, ?, ?, ?)"; // invoice_id skipped
    values = [
        invoiceChargeTable,
        invoice.charge_id,
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