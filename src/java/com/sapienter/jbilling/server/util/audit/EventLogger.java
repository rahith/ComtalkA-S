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

package com.sapienter.jbilling.server.util.audit;

import java.util.Date;


import com.sapienter.jbilling.server.user.db.CompanyDAS;
import com.sapienter.jbilling.server.user.db.UserDAS;
import com.sapienter.jbilling.server.util.Context;
import com.sapienter.jbilling.server.util.audit.db.EventLogDAS;
import com.sapienter.jbilling.server.util.audit.db.EventLogDTO;
import com.sapienter.jbilling.server.util.audit.db.EventLogMessageDAS;
import com.sapienter.jbilling.server.util.audit.db.EventLogModuleDAS;
import com.sapienter.jbilling.server.util.db.JbillingTableDAS;

public class EventLogger {

    // these are the messages constants, in synch with the db (event_log_message)
    // billing process
    public static final Integer BILLING_PROCESS_UNBILLED_PERIOD = Integer.valueOf(1);
    public static final Integer BILLING_PROCESS_NOT_ACTIVE_YET = Integer.valueOf(2);
    public static final Integer BILLING_PROCESS_ONE_PERIOD_NEEDED = Integer.valueOf(3);
    public static final Integer BILLING_PROCESS_RECENTLY_BILLED = Integer.valueOf(4);
    public static final Integer BILLING_PROCESS_WRONG_FLAG_ON = Integer.valueOf(5);
    public static final Integer BILLING_PROCESS_EXPIRED = Integer.valueOf(6);
    public static final Integer BILLING_REVIEW_NOT_APPROVED = Integer.valueOf(10);
    public static final Integer BILLING_REVIEW_NOT_GENERATED = Integer.valueOf(11);
    // user maintenance
    public static final Integer PASSWORD_CHANGE = Integer.valueOf(8);
    public static final Integer STATUS_CHANGE = Integer.valueOf(12);
    public static final Integer NO_FURTHER_STEP = Integer.valueOf(14);
    public static final Integer CANT_PAY_PARTNER = Integer.valueOf(15);
    public static final Integer SUBSCRIPTION_STATUS_CHANGE = Integer.valueOf(20);
    public static final Integer SUBSCRIPTION_STATUS_NO_CHANGE = Integer.valueOf(32);
    public static final Integer ACCOUNT_LOCKED = Integer.valueOf(21);
    public static final Integer DYNAMIC_BALANCE_CHANGE = Integer.valueOf(33);
    public static final Integer INVOICE_IF_CHILD_CHANGE = Integer.valueOf(34);
    // order maintenance
    public static final Integer ORDER_STATUS_CHANGE = Integer.valueOf(13);
    public static final Integer ORDER_LINE_UPDATED = Integer.valueOf(17);
    public static final Integer ORDER_NEXT_BILL_DATE_UPDATED = Integer.valueOf(18);
    public static final Integer ORDER_MAIN_SUBSCRIPTION_UPDATED = Integer.valueOf(22);
    public static final Integer ORDER_CANCEL_AND_CREDIT = Integer.valueOf(26);
    // payment
    public static final Integer PAYMENT_INSTRUMENT_NOT_FOUND = Integer.valueOf(24);
    // invoice related message
    public static final Integer INVOICE_ORDER_APPLIED = Integer.valueOf(16);
    // mediation
    public static final Integer CURRENT_ORDER_FINISHED = Integer.valueOf(23);
    // blacklist
    public static final Integer BLACKLIST_USER_ID_ADDED = Integer.valueOf(27);
    public static final Integer BLACKLIST_USER_ID_REMOVED = Integer.valueOf(28);
    //provisioning
    public static final Integer PROVISIONING_UUID = Integer.valueOf(29);
    public static final Integer PROVISIONING_COMMAND=Integer.valueOf(30);
    public static final Integer PROVISIONING_STATUS_CHANGE=Integer.valueOf(31);

    // others
    public static final Integer ROW_CREATED = Integer.valueOf(25);
    public static final Integer ROW_DELETED = Integer.valueOf(7);
    public static final Integer ROW_UPDATED= Integer.valueOf(9); // field not specified
    public static final Integer USER_TRANSITIONS_LIST = Integer.valueOf(19);


    // event log modules in synch with db (event_log_module)
    public static final Integer MODULE_BILLING_PROCESS = Integer.valueOf(1);
    public static final Integer MODULE_USER_MAINTENANCE = Integer.valueOf(2);
    public static final Integer MODULE_ITEM_MAINTENANCE = Integer.valueOf(3);
    public static final Integer MODULE_ITEM_TYPE_MAINTENANCE = Integer.valueOf(4);
    public static final Integer MODULE_ITEM_USER_PRICE_MAINTENANCE = Integer.valueOf(5);
    public static final Integer MODULE_PROMOTION_MAINTENANCE = Integer.valueOf(6);
    public static final Integer MODULE_ORDER_MAINTENANCE = Integer.valueOf(7);
    public static final Integer MODULE_CREDIT_CARD_MAINTENANCE = Integer.valueOf(8);
    public static final Integer MODULE_INVOICE_MAINTENANCE = Integer.valueOf(9);
    public static final Integer MODULE_PAYMENT_MAINTENANCE = Integer.valueOf(10);
    public static final Integer MODULE_TASK_MAINTENANCE = Integer.valueOf(11);
    public static final Integer MODULE_WEBSERVICES = Integer.valueOf(12);
    public static final Integer MODULE_MEDIATION = Integer.valueOf(13);
    public static final Integer MODULE_BLACKLIST = Integer.valueOf(14);
    public static final Integer MODULE_PROVISIONING=Integer.valueOf(15);


    // levels of logging
    public static final Integer LEVEL_DEBUG = Integer.valueOf(1);
    public static final Integer LEVEL_INFO = Integer.valueOf(2);
    public static final Integer LEVEL_WARNING = Integer.valueOf(3);
    public static final Integer LEVEL_ERROR = Integer.valueOf(4);
    public static final Integer LEVEL_FATAL = Integer.valueOf(5);

    private EventLogDAS eventLogDAS = null;
    private EventLogMessageDAS eventLogMessageDAS = null;
    private EventLogModuleDAS eventLogModuleDAS = null;
    private JbillingTableDAS jbDAS = null;

    //private static final Logger LOG = Logger.getLogger(EventLogger.class);

    public EventLogger() {
        eventLogDAS = new EventLogDAS();
        eventLogMessageDAS = new EventLogMessageDAS();
        eventLogModuleDAS = new EventLogModuleDAS();
        jbDAS = (JbillingTableDAS) Context.getBean(Context.Name.JBILLING_TABLE_DAS);
    }

    public static EventLogger getInstance() {
        return new EventLogger();
    }

    public void log(Integer level, Integer entity, Integer userAffectedId,
            Integer rowId, Integer module, Integer message, String table)  {
        CompanyDAS company = new CompanyDAS();
        UserDAS user= new UserDAS();
        EventLogDTO dto = new EventLogDTO(null, jbDAS.findByName(table), null,
                user.find(userAffectedId), eventLogMessageDAS.find(message),
                eventLogModuleDAS.find(module), company.find(entity), rowId,
                level, null, null, null);
        eventLogDAS.save(dto);
    }

    public void debug(Integer entity, Integer userAffectedId, Integer rowId,
            Integer module, Integer message, String table)   {
        log(LEVEL_DEBUG, entity, userAffectedId, rowId, module, message, table);
    }

    public void info(Integer entity, Integer userAffectedId, Integer rowId,
            Integer module, Integer message, String table) {
        log(LEVEL_INFO, entity, userAffectedId, rowId, module, message, table);
    }

    public void warning(Integer entity, Integer userAffectedId, Integer rowId,
            Integer module, Integer message, String table)   {
        log(LEVEL_WARNING, entity, userAffectedId, rowId, module, message,
                table);
    }

    public void error(Integer entity, Integer userAffectedId, Integer rowId,
            Integer module, Integer message, String table)   {
        log(LEVEL_ERROR, entity, userAffectedId, rowId, module, message, table);
    }

    public void fatal(Integer entity, Integer userAffectedId, Integer rowId,
            Integer module, Integer message, String table)   {
        log(LEVEL_FATAL, entity, userAffectedId, rowId, module, message, table);
    }

    /*
     * This is intended for loggin a change in the database, where we want to
     * keep track of what changed
     */
    public void audit(Integer userExecutingId, Integer userAffectedId,
            String table, Integer rowId, Integer module, Integer message,
            Integer oldInt, String oldStr, Date oldDate) {

        UserDAS user= new UserDAS();

        EventLogDTO dto = new EventLogDTO(null, jbDAS.findByName(table),
                user.find(userExecutingId), (userAffectedId == null) ? null : user.find(userAffectedId),
                eventLogMessageDAS.find(message), eventLogModuleDAS.find(module),
                user.find(userExecutingId).getCompany(), rowId, LEVEL_INFO, oldInt, oldStr, oldDate);
        eventLogDAS.save(dto);

    }


    /*
     * Same as previous but the change its not being done by any given user
     * (no executor) but by a batch process.
     */
    public void auditBySystem(Integer entityId, Integer userAffectedId,
            String table, Integer rowId, Integer module, Integer message,
            Integer oldInt, String oldStr, Date oldDate) {
        CompanyDAS company = new CompanyDAS();
        UserDAS user= new UserDAS();
        EventLogDTO dto = new EventLogDTO(null, jbDAS.findByName(table), null,
                user.find(userAffectedId), eventLogMessageDAS.find(message),
                eventLogModuleDAS.find(module), company.find(entityId), rowId,
                LEVEL_INFO, oldInt, oldStr, oldDate);
        eventLogDAS.save(dto);

    }

    /**
     * Queries the event_log table to determine the position where the last query
     * of the user transitions ended. This is called if the user passes
     * <code>null</code> as the <code>from</code> parameter to the getUserTransitions
     * webservice call.
     * @return the id of the last queried transitions list.
     */
    public Integer getLastTransitionEvent(Integer entityId)  {
        return eventLogDAS.getLastTransitionEvent(entityId);
    }
}
