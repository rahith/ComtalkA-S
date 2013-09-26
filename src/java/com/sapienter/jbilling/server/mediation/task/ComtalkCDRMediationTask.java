package com.sapienter.jbilling.server.mediation.task;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.hibernate.ScrollableResults;

import com.sapienter.jbilling.server.item.db.ItemDAS;
import com.sapienter.jbilling.server.item.db.ItemDTO;
import com.sapienter.jbilling.server.mediation.Record;
import com.sapienter.jbilling.server.order.db.OrderBillingTypeDAS;
import com.sapienter.jbilling.server.order.db.OrderBillingTypeDTO;
import com.sapienter.jbilling.server.order.db.OrderDAS;
import com.sapienter.jbilling.server.order.db.OrderDTO;
import com.sapienter.jbilling.server.order.db.OrderLineDAS;
import com.sapienter.jbilling.server.order.db.OrderLineDTO;
import com.sapienter.jbilling.server.order.db.OrderLineTypeDAS;
import com.sapienter.jbilling.server.order.db.OrderLineTypeDTO;
import com.sapienter.jbilling.server.order.db.OrderPeriodDAS;
import com.sapienter.jbilling.server.order.db.OrderPeriodDTO;
import com.sapienter.jbilling.server.order.db.OrderStatusDAS;
import com.sapienter.jbilling.server.order.db.OrderStatusDTO;
import com.sapienter.jbilling.server.pluggableTask.TaskException;
import com.sapienter.jbilling.server.pluggableTask.admin.ParameterDescription;
import com.sapienter.jbilling.server.pluggableTask.admin.ParameterDescription.Type;
import com.sapienter.jbilling.server.user.contact.db.ContactDAS;
import com.sapienter.jbilling.server.user.contact.db.ContactDTO;
import com.sapienter.jbilling.server.user.db.UserDAS;
import com.sapienter.jbilling.server.util.Constants;
import com.sapienter.jbilling.server.util.db.CurrencyDAS;

public class ComtalkCDRMediationTask extends MediationProcessTask implements IMediationProcess{

	OrderStatusDTO ActiveOrderStatus = null;
	OrderPeriodDTO OrderPeriodOnce = null;
	OrderBillingTypeDTO OrderTypePostPaid = null;
	OrderLineTypeDTO OrderLineTypeItem = null;
	OrderLineTypeDTO OrderLineTypeTax = null;
	private static Logger LOG= Logger.getLogger(ComtalkCDRMediationTask.class);

	protected static final ParameterDescription PARAM_VAT_ITEM = new ParameterDescription("vat_item", true, Type.STR);
	protected static final ParameterDescription PARAM_CURRENCY = new ParameterDescription("currency", true, Type.STR);

	{
		descriptions.add(PARAM_VAT_ITEM);
		descriptions.add(PARAM_CURRENCY);
	}
	public ComtalkCDRMediationTask() {
		//no-op
	}

	@Override
	public void process(List<Record> records, List<MediationResult> results,
			String configurationName) throws TaskException {
		LOG.debug("CDR Mediation started ...........");
		int index = -1;
		if(results != null && results.size() > 0){
			if(records.size() != results.size()){
				throw new TaskException("");
			}
			index = 0;
		}else if (results == null) {
			throw new TaskException("");
		}
		LOG.debug("Now records and results are valid...");
		ActiveOrderStatus = new OrderStatusDAS().find(Constants.ORDER_STATUS_ACTIVE);

		// Get the once order period
		OrderPeriodOnce = new OrderPeriodDAS().find(Constants.ORDER_PERIOD_ONCE);
		// get the post paid order type
		OrderTypePostPaid = new OrderBillingTypeDAS().find(Constants.ORDER_BILLING_POST_PAID);
		// get the item order line type
		OrderLineTypeItem = new OrderLineTypeDAS().find(Constants.ORDER_LINE_TYPE_ITEM);
		// get the tax item order line type
		OrderLineTypeTax = new OrderLineTypeDAS().find(Constants.ORDER_LINE_TYPE_TAX);
		processBatch(records, results, configurationName);
	}

	private void  processBatch(List<Record> records, List<MediationResult> results,String configurationName){
		OrderDTO newOrder = null;
		List<OrderLineDTO> newOrderLines = null;
		Integer vatItem = Integer.valueOf(parameters.get(PARAM_VAT_ITEM.getName()));
		Integer	currencyId = Integer.valueOf(parameters.get(PARAM_CURRENCY.getName()));
		for (Record record : records) {
			//one result per record
			MediationResult result = new MediationResult(configurationName, true);
			//orderlines for mediation
			List<OrderLineDTO> orderLineList = null;
			List<OrderLineDTO> resOrderLineList = new ArrayList<OrderLineDTO> ();
			LOG.debug("record fields........................."+record.getFields());
			String key = record.getFields().get(0).getStrValue();
			result.setRecordKey(key);

			Date start = record.getFields().get(5).getDateValue();
			start = DateUtils.truncate(start, Calendar.MONTH);
			int user_id = record.getFields().get(13).getIntValue();
			String telephone=record.getFields().get(2).getStrValue();
			OrderDTO currentOrder = null;
			Integer currentOrderId = 0;
			BigDecimal rated_amount=BigDecimal.valueOf(record.getFields().get(11).getDoubleValue());
			BigDecimal price_per_min=BigDecimal.valueOf(record.getFields().get(12).getDoubleValue());
			BigDecimal rated_quantity=BigDecimal.valueOf(record.getFields().get(10).getDoubleValue());
			String description="call to"+" "+record.getFields().get(4).getStrValue();
			Integer item_id=record.getFields().get(8).getIntValue();
			OrderDAS oDAS = new OrderDAS();
			ScrollableResults orderList = oDAS.findByUser_Status(user_id, Constants.ORDER_STATUS_ACTIVE);

			// check for existing order
			while (orderList.next()) {
				currentOrder = (OrderDTO) orderList.get()[0];
				if ((currentOrder.getNotes()!= null) && currentOrder.getNotes().equals("Usage order for "+telephone)) {
					Date activeSince = DateUtils.truncate(currentOrder.getActiveSince(),Calendar.MONTH);
					if (activeSince.compareTo(start) == 0) {
						currentOrderId = currentOrder.getId();
						break;
					}
				}
			}

			if(currentOrderId == 0){
				//Assume there is no order available for user
				currentOrder = createOrder(start,user_id,telephone,currencyId);
				orderLineList = currentOrder.getLines();
				OrderLineDTO currentOrderLine = createOrderLine(currentOrder, rated_amount, price_per_min, rated_quantity, description,item_id);
				//Now add orderline to empty list
				orderLineList.add(currentOrderLine);
				//calculate vat for this new order
				ContactDTO cdas=new ContactDAS().findPrimaryContact(user_id);
				String Countrycode=cdas.getCountryCode();
				if(Countrycode.equals("DK")){
					orderLineList.add(createTaxOrderLine(currentOrder,currentOrderLine,vatItem));
				}
				currentOrder.setLines(orderLineList);		
				//Now persist this order
				currentOrder = new OrderDAS().makePersistent(currentOrder);
				LOG.debug("New order created during Mediation... Order Id = "+currentOrder.getId());

			}else{
				OrderLineDTO currentOrderLine = null;
				boolean exists = false;
				for(OrderLineDTO lineDto: currentOrder.getLines()){
					//check for item id
					if(item_id.equals(lineDto.getItem().getId())){
						//check for description
						if(lineDto.getDescription() != null && lineDto.getDescription().equals(description)){
							exists = true;
							currentOrderLine = lineDto;
							break;
						}
					}
				}
				if(exists){
					//Update quantity and amount
					currentOrderLine.setQuantity(currentOrderLine.getQuantity().add(rated_quantity));
					currentOrderLine.setAmount(currentOrderLine.getAmount().add(rated_amount));
				}else{
					// create new order line 
					currentOrderLine = new OrderLineDAS().save(createOrderLine(currentOrder, rated_amount, price_per_min, rated_quantity, description, item_id));
					LOG.debug("New Order line created ...."+currentOrderLine.getId()+"  for "+description);

				}
				orderLineList = currentOrder.getLines();
				orderLineList.add(currentOrderLine);

				//To check vat line for existing vat order line	
				boolean Vatline=false;
				for (OrderLineDTO orderLine : orderLineList) {
					if(orderLine.getItemId().equals(vatItem)){
						Vatline=true;
						if(Vatline) break;
					}
				}

				if(Vatline){	 
					// we need to add tax amount to existing tax order line
					for (OrderLineDTO orderLine : orderLineList) {
						if(orderLine.getItemId().equals(vatItem)){
							ItemDTO taxItem = new ItemDAS().find(vatItem);
							double tax=taxItem.getPercentage().doubleValue();
							double amount=rated_amount.doubleValue();
							BigDecimal taxamount=BigDecimal.valueOf((tax*amount)/100);
							orderLine.setAmount(orderLine.getAmount().add(taxamount));
							break;
						}
					}	

				}
				else{
					//create new vat line
					ContactDTO cdas=new ContactDAS().findPrimaryContact(user_id);
					String Countrycode=cdas.getCountryCode();
					if(Countrycode.equals("DK")){
						orderLineList.add(createTaxOrderLine(currentOrder,currentOrderLine,vatItem));
					}		
				}

				currentOrder.setLines(orderLineList);
				currentOrder = new OrderDAS().makePersistent(currentOrder);

			}
			result.getLines().add(createOrderLine(currentOrder, rated_amount, price_per_min, rated_quantity, description, item_id));
			result.setCurrencyId(currencyId);
			result.setCurrentOrder(currentOrder);
			OrderDTO odto=new OrderDAS().find(currentOrder.getId());
			List<OrderLineDTO> oldto=odto.getLines();
			// check for order lines
			for(OrderLineDTO lineDto: oldto){
				//check for item id
				if(vatItem != lineDto.getItem().getId()){
					//check for description
					if(lineDto.getDescription() != null && lineDto.getDescription().equals(description)){
						result.getLines().get(0).setId(lineDto.getId());
						break;
					}
				}
			}
			result.setDiffLines(result.getLines());			
			result.setEventDate(start);//set start Date
			result.setRecordKey(key);
			result.setDescription(description);
			result.setDone(true);
			results.add(result);
		}

	}

	/**
	 * Create a new order line if not exists
	 * @param currentOrder is the order for which order line is created
	 * @param amount is amount
	 * @param price is the item price
	 * @param quantity is the quantity
	 * @param description is the line description
	 * @param item_id is the item id
	 * @return instance of {@link OrderLineDTO}
	 */
	private OrderLineDTO createOrderLine(OrderDTO currentOrder,BigDecimal amount,BigDecimal price,BigDecimal quantity,String description,Integer item_id){
		OrderLineDTO currentOrderLine = new OrderLineDTO();
		currentOrderLine.setAmount(amount);
		currentOrderLine.setDeleted(0);
		currentOrderLine.setDescription(description);
		currentOrderLine.setQuantity(quantity);
		currentOrderLine.setPrice(price);
		currentOrderLine.setEditable(false);
		currentOrderLine.setUseItem(true);
		currentOrderLine.setOrderLineType(OrderLineTypeItem);
		currentOrderLine.setItem(new ItemDAS().find(item_id));
		currentOrderLine.setCreateDatetime(new Date());
		currentOrderLine.setPurchaseOrder(currentOrder);
		return currentOrderLine;
	}

	/**
	 * Create a new order if no active order found
	 * @param activeSince is the active from date
	 * @param user_id is the user id
	 * @param telephone is the msisdn mapped to user
	 * @param currencyId is the currency id configured for mediation
	 * @return instance of {@link OrderDTO}
	 */
	private OrderDTO createOrder(Date activeSince,int user_id,String telephone,Integer currencyId){
		OrderDTO currentOrder = new OrderDTO();
		currentOrder.setCurrency(new CurrencyDAS().find(currencyId));
		currentOrder.setNotes("Usage order for "+telephone);
		currentOrder.setOrderStatus(ActiveOrderStatus);
		currentOrder.setOrderPeriod(OrderPeriodOnce);
		currentOrder.setOrderBillingType(OrderTypePostPaid);
		currentOrder.setNotify(0);
		currentOrder.setOwnInvoice(0);
		currentOrder.setIsCurrent(0);
		currentOrder.setDfFm(0);
		currentOrder.setCreateDate(new Date());
		currentOrder.setActiveSince(activeSince);
		currentOrder.setActiveUntil(null);
		currentOrder.setDeleted(0);
		currentOrder.setBaseUserByUserId(new UserDAS().find(user_id));
		return currentOrder;
	}

	/**
	 * 
	 * @param currentOrder is the active order
	 * @param currentOrderLine is the order line for which tax is calculated
	 * @param vatItem is the tax item id
	 * @return {@link OrderLineDTO}
	 */
	private OrderLineDTO createTaxOrderLine(OrderDTO currentOrder,OrderLineDTO currentOrderLine,Integer vatItem){
		ItemDTO taxItem = new ItemDAS().find(vatItem);
		double tax=taxItem.getPercentage().doubleValue();
		double amount=currentOrderLine.getAmount().doubleValue();
		BigDecimal taxamount=BigDecimal.valueOf((tax*amount)/100);
		OrderLineDTO taxOrderLine = new OrderLineDTO();
		taxOrderLine.setAmount(taxamount);
		taxOrderLine.setDeleted(0);
		taxOrderLine.setDescription("VAT @ 25%");
		taxOrderLine.setQuantity(1);
		taxOrderLine.setPurchaseOrder(currentOrder);
		taxOrderLine.setPrice(taxItem.getPercentage());
		taxOrderLine.setEditable(false);
		taxOrderLine.setOrderLineType(OrderLineTypeTax);
		taxOrderLine.setItem(taxItem);
		taxOrderLine.setCreateDatetime(new Date());
		return taxOrderLine;
	}
}
