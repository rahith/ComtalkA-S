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
package com.sapienter.jbilling.server.item.tasks;

import java.math.BigDecimal;
import java.util.List;

import org.apache.log4j.Logger;

import com.sapienter.jbilling.server.item.PricingField;
import com.sapienter.jbilling.server.order.db.OrderDTO;
import com.sapienter.jbilling.server.pluggableTask.PluggableTask;
import com.sapienter.jbilling.server.pluggableTask.TaskException;

public class SimpleRulesPricingTask1 extends PluggableTask implements IPricing {
    
    private static final Logger LOG = Logger.getLogger(RulesPricingTask.class);

    public BigDecimal getPrice(Integer itemId, BigDecimal quantity, Integer userId, Integer currencyId,
            List<PricingField> fields, BigDecimal defaultPrice, OrderDTO pricingOrder, boolean singlePurchase)
            throws TaskException {
        // now we have the line with good defaults, the order and the item
        // These have to be visible to the rules
       
        PricingManager manager = new PricingManager(itemId, userId, currencyId, defaultPrice);
        if (manager.getPrice() == null) {
        	manager.setPrice(defaultPrice); // set the default
        }
        return manager.getPrice();
    }
}
