const dateFns = require('date-fns');
const billingService = require('../services/billing.service');

module.exports = {
    generateInvoice,
    createPayment,
};

async function getBill(res, req, next){
    const invoice = {total_amount, amount_paid} = req.body;

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

