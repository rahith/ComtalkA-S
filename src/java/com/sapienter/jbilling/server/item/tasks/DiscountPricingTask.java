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
import java.util.Set;

import org.apache.log4j.Logger;

import com.sapienter.jbilling.server.item.PricingField;
import com.sapienter.jbilling.server.item.db.ItemDAS;
import com.sapienter.jbilling.server.item.db.ItemDTO;
import com.sapienter.jbilling.server.item.db.ItemTypeDAS;
import com.sapienter.jbilling.server.item.db.ItemTypeDTO;
import com.sapienter.jbilling.server.metafields.MetaFieldHelper;
import com.sapienter.jbilling.server.metafields.db.DataType;
import com.sapienter.jbilling.server.metafields.db.MetaField;
import com.sapienter.jbilling.server.metafields.db.MetaFieldDAS;
import com.sapienter.jbilling.server.metafields.db.MetaFieldValue;
import com.sapienter.jbilling.server.order.db.OrderDTO;
import com.sapienter.jbilling.server.pluggableTask.PluggableTask;
import com.sapienter.jbilling.server.pluggableTask.TaskException;
import com.sapienter.jbilling.server.pluggableTask.admin.ParameterDescription;

public class DiscountPricingTask extends PluggableTask implements IPricing {
    
	 public static final ParameterDescription PARAM_DISCOUNT_CATEGORY_ID = 
		        new ParameterDescription("Discount Category Id", false, ParameterDescription.Type.INT);
		    public static final ParameterDescription PARAM_DISCOUNT_PERCENTAGE_META_FIELD_ID = 
		        new ParameterDescription("Discount Percentage Meta Field Id", false, ParameterDescription.Type.INT);    
		    public static final ParameterDescription PARAM_DEFAULT_DISCOUNT_PERCENTAGE = 
		        new ParameterDescription("Default Discount Percentage", false, ParameterDescription.Type.FLOAT);    

		    //initializer for pluggable params
		    { 
		        descriptions.add(PARAM_DISCOUNT_CATEGORY_ID);
		        descriptions.add(PARAM_DISCOUNT_PERCENTAGE_META_FIELD_ID);
		        descriptions.add(PARAM_DEFAULT_DISCOUNT_PERCENTAGE);
		    }
	
    private static final Logger LOG = Logger.getLogger(DiscountPricingTask.class);

    public BigDecimal getPrice(Integer itemId, BigDecimal quantity, Integer userId, Integer currencyId,
            List<PricingField> fields, BigDecimal defaultPrice, OrderDTO pricingOrder, boolean singlePurchase)
            throws TaskException {
    	PricingManager manager = new PricingManager(itemId, userId, currencyId, defaultPrice);
    	ItemDTO item = new ItemDAS().find(itemId);
    	BigDecimal discountPercentage = null;
    	BigDecimal discountedPrice = null;
    	
    	Set<ItemTypeDTO> itemTypes = item.getItemTypes();
    	if (parameters.get(PARAM_DISCOUNT_CATEGORY_ID.getName()) != null) {
    		for (ItemTypeDTO dto : itemTypes) {
    			if (Integer.parseInt(parameters.get(PARAM_DISCOUNT_CATEGORY_ID.getName())) == dto.getId()) {
    				
    				if (parameters.get(PARAM_DISCOUNT_PERCENTAGE_META_FIELD_ID.getName()) != null) {
    				
    					MetaField metaField = 
	    		    			new MetaFieldDAS().find(Integer.parseInt(parameters.get(PARAM_DISCOUNT_PERCENTAGE_META_FIELD_ID.getName())));
    					
    					MetaFieldValue metaFieldValue = 
    							MetaFieldHelper.getMetaField(item, Integer.parseInt(parameters.get(PARAM_DISCOUNT_PERCENTAGE_META_FIELD_ID.getName())));
		    		
			    		if (metaFieldValue != null && 
			    				metaFieldValue.getValue() != null && 
			    					(!metaFieldValue.getValue().toString().isEmpty())) {
			    			
			    			if (DataType.STRING.equals(metaField.getDataType())) {
			    				discountPercentage = new BigDecimal((String)metaFieldValue.getValue());
			    			} else if (DataType.DECIMAL.equals(metaField.getDataType())) {
			    				discountPercentage = (BigDecimal)metaFieldValue.getValue();
			    			} else if (DataType.INTEGER.equals(metaField.getDataType())) {
			    				discountPercentage = new BigDecimal((Integer)metaFieldValue.getValue());
			    			} else {
			    				LOG.error("Invalid Data Type for Percentage Meta Field: "+metaField.getDataType());
			    			}
			    			
			    			LOG.debug("discountPercentage using meta field: "+discountPercentage);
			    		} 
			    		
		    		} else if (parameters.get(PARAM_DEFAULT_DISCOUNT_PERCENTAGE.getName()) != null && 
		    				!parameters.get(PARAM_DEFAULT_DISCOUNT_PERCENTAGE.getName()).isEmpty()) {
		    			
		        		discountPercentage = new BigDecimal(parameters.get(PARAM_DEFAULT_DISCOUNT_PERCENTAGE.getName()));
		        	} else {
		    			
		        		discountPercentage = BigDecimal.ZERO;
		        	}
    				
    			}
    		}
    	}
    	
    	if (discountPercentage != null) {
    		discountedPrice = manager.getPrice().multiply(discountPercentage).divide(new BigDecimal(100));
    		return manager.getPrice().subtract(discountedPrice);
    	}
        return manager.getPrice();
    }
}
