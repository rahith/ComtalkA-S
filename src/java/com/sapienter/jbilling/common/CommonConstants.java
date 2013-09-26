/*
 * JBILLING CONFIDENTIAL
 * _____________________
 *
 * [2003] - [2012] Enterprise jBilling Software Ltd.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Enterprise jBilling Software.
 * The intellectual and technical concepts contained
 * herein are proprietary to Enterprise jBilling Software
 * and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden.
 */

package com.sapienter.jbilling.common;

import org.joda.time.DateMidnight;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author Emil
 */
public interface CommonConstants {

    public static final Date EPOCH_DATE = new DateMidnight(1970, 1, 1).toDate();

    public static final String LIST_TYPE_ITEM_TYPE = "type";
    public static final String LIST_TYPE_CUSTOMER = "customer";
    public static final String LIST_TYPE_CUSTOMER_SIMPLE = "customerSimple";
    public static final String LIST_TYPE_PARTNERS_CUSTOMER = "partnersCustomer";
    public static final String LIST_TYPE_SUB_ACCOUNTS = "sub_accounts";
    public static final String LIST_TYPE_ITEM = "item";
    public static final String LIST_TYPE_ITEM_ORDER = "itemOrder";
    public static final String LIST_TYPE_ITEM_USER_PRICE = "price";
    public static final String LIST_TYPE_PROMOTION = "promotion";
    public static final String LIST_TYPE_PAYMENT = "payment";
    public static final String LIST_TYPE_PAYMENT_USER = "paymentUser";
    public static final String LIST_TYPE_ORDER = "order";
    public static final String LIST_TYPE_INVOICE = "invoice";
    public static final String LIST_TYPE_REFUND = "refund";
    public static final String LIST_TYPE_INVOICE_GRAL = "invoiceGeneral";
    public static final String LIST_TYPE_PROCESS = "process";
    public static final String LIST_TYPE_PROCESS_INVOICES = "processInvoices";
    public static final String LIST_TYPE_PROCESS_RUN_SUCCESSFULL_USERS = "processRunSuccessfullUsers";
    public static final String LIST_TYPE_PROCESS_RUN_FAILED_USERS = "processRunFailedUsers";
    public static final String LIST_TYPE_PROCESS_ORDERS= "processOrders";
    public static final String LIST_TYPE_NOTIFICATION_TYPE= "notificationType";
    public static final String LIST_TYPE_PARTNER = "partner";
    public static final String LIST_TYPE_PAYOUT = "payout";
    public static final String LIST_TYPE_INVOICE_ORDER = "invoicesOrder";

    // results from payments
    // this has to by in synch with how the database is initialized
    public static final Integer RESULT_OK = new Integer(1);
    public static final Integer RESULT_FAIL = new Integer(2);
    public static final Integer RESULT_UNAVAILABLE = new Integer(3);
    public static final Integer RESULT_ENTERED = new Integer(4);
    // a special one, to represent 'no result' (for filers, routers, etc)
    public static final Integer RESULT_NULL = Integer.valueOf(0);

    // user types, these have to by in synch with the user_type table
    // these are needed in the server side and the jsps
    public static final Integer TYPE_INTERNAL = Integer.valueOf(1);
    public static final Integer TYPE_ROOT = Integer.valueOf(2);
    public static final Integer TYPE_CLERK = Integer.valueOf(3);
    public static final Integer TYPE_PARTNER = Integer.valueOf(4);
    public static final Integer TYPE_CUSTOMER = Integer.valueOf(5);

    // payment methods (db - synch)
    public static final Integer PAYMENT_METHOD_CHEQUE = Integer.valueOf(1);
    public static final Integer PAYMENT_METHOD_VISA = Integer.valueOf(2);
    public static final Integer PAYMENT_METHOD_MASTERCARD = Integer.valueOf(3);
    public static final Integer PAYMENT_METHOD_AMEX = Integer.valueOf(4);
    public static final Integer PAYMENT_METHOD_ACH = Integer.valueOf(5);
    public static final Integer PAYMENT_METHOD_DISCOVERY = Integer.valueOf(6);
    public static final Integer PAYMENT_METHOD_DINERS = Integer.valueOf(7);
    public static final Integer PAYMENT_METHOD_PAYPAL = Integer.valueOf(8);
    public static final Integer PAYMENT_METHOD_GATEWAY_KEY = Integer.valueOf(9);

    //payment result
    public static final Integer PAYMENT_RESULT_SUCCESSFUL = Integer.valueOf(1);
    public static final Integer PAYMENT_RESULT_FAILED = Integer.valueOf(2);
    public static final Integer PAYMENT_RESULT_PROCESSOR_UNAVAILABLE = Integer.valueOf(3);
    public static final Integer PAYMENT_RESULT_ENTERED = Integer.valueOf(4);

    // billing process review status
    public static final Integer REVIEW_STATUS_GENERATED = new Integer(1);
    public static final Integer REVIEW_STATUS_APPROVED = new Integer(2);
    public static final Integer REVIEW_STATUS_DISAPPROVED = new Integer(3);

    // these are the preference's types. This has to be in synch with the DB
    //public static Integer PREFERENCE_PAYMENT_WITH_PROCESS = Integer.valueOf(1); obsolete
    public static Integer PREFERENCE_CSS_LOCATION = Integer.valueOf(2);
    public static Integer PREFERENCE_LOGO_LOCATION = Integer.valueOf(3);
    public static Integer PREFERENCE_GRACE_PERIOD = Integer.valueOf(4);
    public static Integer PREFERENCE_PART_DEF_RATE = Integer.valueOf(5);
    public static Integer PREFERENCE_PART_DEF_FEE = Integer.valueOf(6);
    public static Integer PREFERENCE_PART_DEF_ONE_TIME = Integer.valueOf(7);
    public static Integer PREFERENCE_PART_DEF_PER_UNIT = Integer.valueOf(8);
    public static Integer PREFERENCE_PART_DEF_PER_VALUE = Integer.valueOf(9);
    public static Integer PREFERENCE_PART_DEF_AUTOMATIC = Integer.valueOf(10);
    public static Integer PREFERENCE_PART_DEF_CLERK = Integer.valueOf(11);
    public static Integer PREFERENCE_PART_DEF_FEE_CURR = Integer.valueOf(12);
    public static Integer PREFERENCE_PAPER_SELF_DELIVERY = Integer.valueOf(13);
    public static Integer PREFERENCE_SHOW_NOTE_IN_INVOICE = Integer.valueOf(14);
    public static Integer PREFERENCE_DAYS_ORDER_NOTIFICATION_S1 = Integer.valueOf(15);
    public static Integer PREFERENCE_DAYS_ORDER_NOTIFICATION_S2 = Integer.valueOf(16);
    public static Integer PREFERENCE_DAYS_ORDER_NOTIFICATION_S3 = Integer.valueOf(17);
    public static Integer PREFERENCE_INVOICE_PREFIX = Integer.valueOf(18);
    public static Integer PREFERENCE_INVOICE_NUMBER = Integer.valueOf(19);
    public static Integer PREFERENCE_INVOICE_DELETE = Integer.valueOf(20);
    public static Integer PREFERENCE_USE_INVOICE_REMINDERS = Integer.valueOf(21);
    public static Integer PREFERENCE_FIRST_REMINDER = Integer.valueOf(22);
    public static Integer PREFERENCE_NEXT_REMINDER = Integer.valueOf(23);
    public static Integer PREFERENCE_USE_DF_FM = Integer.valueOf(24);
    public static Integer PREFERENCE_USE_OVERDUE_PENALTY = Integer.valueOf(25);
    public static Integer PREFERENCE_PAGE_SIZE = Integer.valueOf(26);
    public static Integer PREFERENCE_USE_ORDER_ANTICIPATION = Integer.valueOf(27);
    public static Integer PREFERENCE_PAYPAL_ACCOUNT = Integer.valueOf(28);
    public static Integer PREFERENCE_PAYPAL_BUTTON_URL = Integer.valueOf(29);
    public static Integer PREFERENCE_URL_CALLBACK = Integer.valueOf(30);
    public static Integer PREFERENCE_CONTINUOUS_DATE = Integer.valueOf(31);
    public static Integer PREFERENCE_PDF_ATTACHMENT= Integer.valueOf(32);
    public static Integer PREFERENCE_ORDER_OWN_INVOICE = Integer.valueOf(33);
    public static Integer PREFERENCE_PRE_AUTHORIZE_CC = Integer.valueOf(34);
    public static Integer PREFERENCE_ORDER_IN_INVOICE_LINE = Integer.valueOf(35);
    public static Integer PREFERENCE_CUSTOMER_CONTACT_EDIT = Integer.valueOf(36);
    public static Integer PREFERENCE_HIDE_CC_NUMBERS = Integer.valueOf(37);
    public static Integer PREFERENCE_LINK_AGEING_TO_SUBSCRIPTION = Integer.valueOf(38);
    public static Integer PREFERENCE_FAILED_LOGINS_LOCKOUT = Integer.valueOf(39);
    public static Integer PREFERENCE_PASSWORD_EXPIRATION = Integer.valueOf(40);
    public static Integer PREFERENCE_USE_CURRENT_ORDER = Integer.valueOf(41);
    public static Integer PREFERENCE_USE_PRO_RATING = Integer.valueOf(42);
    public static Integer PREFERENCE_USE_BLACKLIST = Integer.valueOf(43);
    public static Integer PREFERENCE_ALLOW_NEGATIVE_PAYMENTS = Integer.valueOf(44);
    public static Integer PREFERENCE_DELAY_NEGATIVE_PAYMENTS = Integer.valueOf(45);
    public static Integer PREFERENCE_ALLOW_INVOICES_WITHOUT_ORDERS = Integer.valueOf(46);
    public static Integer PREFERENCE_MEDIATION_JDBC_READER_LAST_ID = Integer.valueOf(47);
    public static Integer PREFERENCE_USE_PROVISIONING = Integer.valueOf(48);
    public static Integer PREFERENCE_AUTO_RECHARGE_THRESHOLD = Integer.valueOf(49);
    public static Integer PREFERENCE_INVOICE_DECIMALS = Integer.valueOf(50);

    // order status, in synch with db
    public static final Integer ORDER_STATUS_ACTIVE = Integer.valueOf(1);
    public static final Integer ORDER_STATUS_FINISHED = Integer.valueOf(2);
    public static final Integer ORDER_STATUS_SUSPENDED = Integer.valueOf(3);
    public static final Integer ORDER_STATUS_SUSPENDED_AGEING = Integer.valueOf(4);

    // invoice status, in synch with db
    public static final Integer INVOICE_STATUS_PAID = Integer.valueOf(1);
    public static final Integer INVOICE_STATUS_UNPAID = Integer.valueOf(2);
    public static final Integer INVOICE_STATUS_UNPAID_AND_CARRIED = Integer.valueOf(3);

    // process run status, in synch with db
    public static final Integer PROCESS_RUN_STATUS_RINNING = new Integer(1);
    public static final Integer PROCESS_RUN_STATUS_SUCCESS = new Integer(2);
    public static final Integer PROCESS_RUN_STATUS_FAILED = new Integer(3);

    // invoice delivery method types
    public static final Integer D_METHOD_EMAIL = new Integer(1);
    public static final Integer D_METHOD_PAPER = new Integer(2);
    public static final Integer D_METHOD_EMAIL_AND_PAPER = new Integer(3);

    // automatic payment methods
    // how a customer wants to pay in the automatic process
    public static final Integer AUTO_PAYMENT_TYPE_CC = new Integer(1);
    public static final Integer AUTO_PAYMENT_TYPE_ACH =  new Integer(2);
    public static final Integer AUTO_PAYMENT_TYPE_CHEQUE = new Integer(3);

    // types of PDF batch generation
    public static final Integer OPERATION_TYPE_CUSTOMER = new Integer(1);
    public static final Integer OPERATION_TYPE_RANGE = new Integer(2);
    public static final Integer OPERATION_TYPE_PROCESS = new Integer(3);
    public static final Integer OPERATION_TYPE_DATE = new Integer(4);
    public static final Integer OPERATION_TYPE_NUMBER = new Integer(5);

    /**
     * BigDecimal caculation constants <br/>
     * This value must be inline with underlying SQL data type
     */
    public static final int BIGDECIMAL_SCALE = 10;
    /**
     * Round to 2 decimals for view. Use it with formatters and/or toString
     */
    public static final int BIGDECIMAL_SCALE_STR = 2;
    public static final int BIGDECIMAL_ROUND = BigDecimal.ROUND_HALF_UP;

    public static final BigDecimal BIGDECIMAL_ONE = new BigDecimal("1");
    public static final BigDecimal BIGDECIMAL_ONE_CENT = new BigDecimal("0.01");

    // codes for login resuls
    public final static Integer AUTH_OK = Integer.valueOf(0);
    public final static Integer AUTH_WRONG_CREDENTIALS = Integer.valueOf(1);
    public final static Integer AUTH_LOCKED = Integer.valueOf(2);  // invalid login creds - bad attempt locked account
    public final static Integer AUTH_EXPIRED = Integer.valueOf(3); // login creds ok - password expired and needs updating

    // provisioning status constants
    public final static Integer PROVISIONING_STATUS_ACTIVE=Integer.valueOf(1);
    public final static Integer PROVISIONING_STATUS_INACTIVE=Integer.valueOf(2);
    public final static Integer PROVISIONING_STATUS_PENDING_ACTIVE=Integer.valueOf(3);
    public final static Integer PROVISIONING_STATUS_PENDING_INACTIVE=Integer.valueOf(4);
    public final static Integer PROVISIONING_STATUS_FAILED=Integer.valueOf(5);
    public final static Integer PROVISIONING_STATUS_UNAVAILABLE = Integer.valueOf(6);

    // types of balances
    public final static Integer BALANCE_NO_DYNAMIC = Integer.valueOf(1); // the default
    public final static Integer BALANCE_PRE_PAID = Integer.valueOf(2);
    public final static Integer BALANCE_CREDIT_LIMIT = Integer.valueOf(3);

    // mediation record status
    public final static Integer MEDIATION_RECORD_STATUS_DONE_AND_BILLABLE = Integer.valueOf(1);
    public final static Integer MEDIATION_RECORD_STATUS_DONE_AND_NOT_BILLABLE = Integer.valueOf(2);
    public final static Integer MEDIATION_RECORD_STATUS_ERROR_DETECTED = Integer.valueOf(3);
    public final static Integer MEDIATION_RECORD_STATUS_ERROR_DECLARED = Integer.valueOf(4);
}
