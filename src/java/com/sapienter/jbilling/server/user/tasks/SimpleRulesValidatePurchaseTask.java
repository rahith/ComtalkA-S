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

package com.sapienter.jbilling.server.user.tasks;

import java.math.BigDecimal;
import java.util.LinkedList;
import java.util.List;

import com.sapienter.jbilling.server.item.PricingField;
import com.sapienter.jbilling.server.item.db.ItemDTO;
import com.sapienter.jbilling.server.pluggableTask.PluggableTask;
import com.sapienter.jbilling.server.pluggableTask.TaskException;
import com.sapienter.jbilling.server.user.ValidatePurchaseWS;
import com.sapienter.jbilling.server.user.db.CustomerDTO;

/**
 * Pluggable task allows running rules for validatePurchase API method.
 */
public class SimpleRulesValidatePurchaseTask extends PluggableTask 
        implements IValidatePurchaseTask {

    public ValidatePurchaseWS validate(CustomerDTO customer, 
            List<ItemDTO> items, List<BigDecimal> amounts, 
            ValidatePurchaseWS result, List<List<PricingField>> fields) 
            throws TaskException {

        if (!result.getAuthorized()) {
            return result;
        }

        BigDecimal amount = BigDecimal.ZERO;
        for (BigDecimal a : amounts) {
            amount = amount.add(a);
        }

        return result;
    }

    public static class ValidatePurchase {
        private BigDecimal amount;
        private List<String> messages;

        public ValidatePurchase(BigDecimal amount) {
            this.amount = amount;
            messages = new LinkedList<String>();
        }

        public BigDecimal getAmount() {
            return amount;
        }

        public void addMessage(String message) {
            messages.add(message);
        }

        public List<String> getMessages() {
            return messages;
        }
    }
}
