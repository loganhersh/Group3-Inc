/*
 As will billing.services.js, all functions are modeled after
 the same function. I didn't focus on proper error handling
 or bad params etc because I wanted to get the functions
 right. However, I'm still not exactly sure what to do,
 so again they're modeled in the exact same way. Again,
 foreign key references are skipped because I didn't know
 how to handle them.
*/

const billingService = require('../services/billing.service');

module.exports = {
    generateInvoice,
    createPayment,
    chargeInvoice
};

async function createUser(res, req, next) {
    const invoice = {total_amount, amount_paid} = req.body;

    billingService.generateInvoice(invoice).then(success => {
        success ? res.status(200).json({message: "invoice successfully created"}) :
            res.status(400).json({message: "error creating invoice"});
    })
        .catch(err => {
            if(err.code === 'ER_DUP_ENTRY') {
                console.log("ERROR HANDLED");
                res.status(409).json({message: "invoice already exists"});
            } else {
                res.status(400).json({message: "Bad request: expected data missing"});
            }
        });
}

async function insertPayment(res, req, next) {
    const payment = {
        payment_id, payment_date, payment_type, payment_amount,
        accountholder_id, account_number, expiration_month,
        expiration_year, card_cvv, card_network
    } = req.body;

    billingService.createPayment(payment).then(success => {
        success ? res.status(200).json({message: "payment successfully created"}) :
            res.status(400).json({message: "error creating payment"});
    })
        .catch(err => {
            if(err.code === 'ER_DUP_ENTRY') {
                console.log("ERROR HANDLED");
                res.status(409).json({message: "payment info already exists"});
            } else {
                res.status(400).json({message: "Bad request: expected data missing"});
            }
        });
}

async function createInvoiceCharge(res, req, next) {
    const invoiceCharge = {charge_id, date_applied, charge_amount, charge_reason} = req.body;

    billingService.chargeInvoice(invoiceCharge).then(success => {
        success ? res.status(200).json({message: "invoice charge successfully created"}) :
            res.status(400).json({message: "error creating invoice charge"});
    })
        .catch(err => {
            if(err.code === 'ER_DUP_ENTRY') {
                console.log("ERROR HANDLED");
                res.status(409).json({message: "invoice charge already exists"});
            } else {
                res.status(400).json({message: "Bad request: expected data missing"});
            }
        });
}

