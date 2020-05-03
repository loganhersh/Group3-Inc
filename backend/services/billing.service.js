/** This is incomplete, but I wanted to show the progress to check if I'm going in the right direction (based off
 * the notes I included below and the things I mentioned on Slack. I'll continue working on this and the controller in
 * the meanwhile, and I'll make any changes you see necessary.
 */

const dateFns = require('date-fns');
const db = require('../db/db');

module.exports = {
    createCCPayment,
    createCAPayment,
    chargeInvoice,
    getBill,
    getReceipt
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
    const query = "INSERT INTO PAYMENT VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    values = [
        payment.payment_id,
        payment.invoice_id,
        DATE_FORMAT(payment.payment_date, '%Y-%m-%e'),
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
    var payment_id = "";
    var invoice_id = "";

    // Generates payment when the cash option is selected
    const query = "INSERT INTO PAYMENT(payment_id, invoice_id, payment_date, payment_type, " +
        "payment_amount, accountholder_name) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    values = [
        payment.payment_id,
        payment.invoice_id,
        DATE_FORMAT(payment.payment_date, '%Y-%m-%e'),
        payment.payment_type,
        payment.payment_amount,
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
    var charge_Id = "";
    var invoice_id = "";

    // Creates and invoice charge
    const query = "INSERT INTO INVOICECHARGE VALUES(?, ?, ?, ?, ?)";
    values = [
        charge_id,
        invoice_id,
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

/**
 * Same issue as below.
 */

function getBill(invoiceid) {
    // Creates and invoice charge
    const query = "INSERT INTO INVOICECHARGE VALUES(?, ?, ?, ?, ?)";
    const billGeneratorQuery = "SELECT ";
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

/**
 The problem with this function is that it's very convoluted and I don't think the joining is happening
 properly, + I don't really know what to do with the values. My alternate idea is what I said on Slack by
 breaking it up into different functions across services or (correcting and) declaring the query constant
 as a field variable and taking values in across different functions as you did in reservations.service.js
 */

function getReceipt(invoiceid) {
    // Creates and invoice charge
    //const query = "INSERT INTO INVOICECHARGE VALUES(?, ?, ?, ?, ?)";
    const receiptGeneratorQuery = "SELECT i.invoice_id AS 'InvoiceID', i.amount_paid AS 'AmountPaid'," +
        "i.total_amount AS 'TotalAmount', r.check_in_date AS 'CheckInDate', r.check_out_date AS 'CheckOutDate" +
        "c.charge_id as 'ChargeID', c.date_applied as 'DateApplied', c.charge_amount as 'ChargeAmount'," +
        "c.charge_reason as 'ChargeReason', g.guest_firstname" +
        "FROM INVOICE AS i" +
        "JOIN RESERVATION AS r ON i.reservation_id = i.reservation_id" +
        "JOIN GUEST AS g ON r.guest_id = g.guest_id" +
        "JOIN INVOICECHARGE as c ON i.invoice_id = c.invoice_id" +
        "JOIN PAYMENT as p ON i.invoice_id = p.invoice_id";
    values = [
        'i', 'invoice_id',
        'i', 'amount_paid'
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

/** TO-DO */
function generateInvoiceID(invoiceID) {

}