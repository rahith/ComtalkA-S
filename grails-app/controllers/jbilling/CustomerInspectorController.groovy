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

package jbilling

import com.sapienter.jbilling.server.invoice.db.InvoiceDTO
import com.sapienter.jbilling.server.item.CurrencyBL
import com.sapienter.jbilling.common.CommonConstants
import com.sapienter.jbilling.common.SessionInternalError
import com.sapienter.jbilling.server.item.db.ItemDTO
import com.sapienter.jbilling.server.order.db.OrderDAS
import com.sapienter.jbilling.server.payment.db.PaymentDTO
import com.sapienter.jbilling.server.user.ContactWS
import com.sapienter.jbilling.server.user.contact.db.ContactTypeDAS
import com.sapienter.jbilling.server.user.db.CompanyDTO
import com.sapienter.jbilling.server.user.db.UserDTO
import com.sapienter.jbilling.server.payment.blacklist.BlacklistBL
import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

@Secured(["CUSTOMER_13"])
class CustomerInspectorController {

	def webServicesSession
    def viewUtils

    def breadcrumbService
    def productService

	def index = {
		redirect action: 'inspect', params: params
	}

	def inspect = {
		def user = params.id ? UserDTO.get(params.int('id')) : null

        if (!user) {
            flash.error = 'no.user.found'
            flash.args = [ params.id as String ]
            return // todo: show generic error page
        }

        def revenue =  webServicesSession.getTotalRevenueByUser(user.id)
        def subscriptions = webServicesSession.getUserSubscriptions(user.id)

        // last invoice
        def invoiceIds = webServicesSession.getLastInvoices(user.id, 1)
        def invoice = invoiceIds ? InvoiceDTO.get(invoiceIds.first()) : null

        // last payment
        def paymentIds = webServicesSession.getLastPayments(user.id, 1)
        def payment = paymentIds ? PaymentDTO.get(paymentIds.first()) : null

        // extra contacts and contact type descriptions
        def contacts = user ? webServicesSession.getUserContactsWS(user.id) : null
        for (ContactWS contact : contacts) {
            def contactType = new ContactTypeDAS().find(contact.type)
            contact.setContactTypeDescr(contactType?.getDescription(session['language_id'].toInteger()))
        }

        // blacklist matches
        def blacklistMatches = BlacklistBL.getBlacklistMatches(user.id)

        // used to find the next invoice date
        def cycle = new OrderDAS().findEarliestActiveOrder(user.id)

        // all customer prices and products
        def company = CompanyDTO.get(session['company_id'])
        def itemTypes = company.itemTypes.sort{ it.id }
        params.typeId = !itemTypes.isEmpty() ? itemTypes?.asList()?.first()?.id : null


        breadcrumbService.addBreadcrumb(controllerName, actionName, null, params.int('id'))

        [
                user: user,
                contacts: contacts,
                blacklistMatches: blacklistMatches,
                invoice: invoice,
                payment: payment,
                subscriptions: subscriptions,
                company: company,
                itemTypes: itemTypes,
                currencies: retrieveCurrencies(),
                cycle: cycle,
                revenue: revenue
        ]
    }

    // Customer specific pricing
    def filterProducts = {
        def company = CompanyDTO.get(session['company_id'])
        def itemTypes = company.itemTypes.sort{ it.id }

        // filter using the first item type by default
        if (params.typeId == null)
            params.typeId = itemTypes?.asList()?.first()?.id

        def products =  productService.getFilteredProducts(company, params)

        render template: 'products', model: [ itemTypes: itemTypes, products: products ]
    }
   
    def updateStrategy = {
        def price = params."price.id" ? getCustomerPrice(params.int('userId'), params.int('price.id')) : null
        def priceModel = PlanHelper.bindPriceModel(params)
        def startDate = new Date().parse(message(code: 'date.format'), params.startDate)

        render template: '/priceModel/model', model: [ model: priceModel, startDate: startDate, models: price?.models, currencies: retrieveCurrencies() ]
    }

    def addAttribute = {
        def price = params."price.id" ? getCustomerPrice(params.int('userId'), params.int('price.id')) : null
        def priceModel = PlanHelper.bindPriceModel(params)
        def startDate = new Date().parse(message(code: 'date.format'), params.startDate)

        def modelIndex = params.int('modelIndex')
        def attribute = message(code: 'plan.new.attribute.key', args: [ params.attributeIndex ])

        // find the model in the chain, and add a new attribute
        def model = priceModel
        for (int i = 0; model != null; i++) {
            if (i == modelIndex) {
                model.attributes.put(attribute, '')
            }
            model = model.next
        }

        render template: '/priceModel/model', model: [ model: priceModel, startDate: startDate, models: price?.models, currencies: retrieveCurrencies() ]
    }

    def removeAttribute = {
        def price = params."price.id" ? getCustomerPrice(params.int('userId'), params.int('price.id')) : null
        def priceModel = PlanHelper.bindPriceModel(params)
        def startDate = new Date().parse(message(code: 'date.format'), params.startDate)

        def modelIndex = params.int('modelIndex')
        def attributeIndex = params.int('attributeIndex')

        // find the model in the chain, remove the attribute
        def model = priceModel
        for (int i = 0; model != null; i++) {
            if (i == modelIndex) {
                def name = params["model.${modelIndex}.attribute.${attributeIndex}.name"]
                model.attributes.remove(name)
            }
            model = model.next
        }

        render template: '/priceModel/model', model: [ model: priceModel, startDate: startDate, models: price?.models, currencies: retrieveCurrencies() ]
    }

    /**
     * Deletes a customer-specific price.
     */
    def deleteCustomerPrice = {
        def userId = params.int('userId')
        def planItemId = params.int('id')

        try {
            log.debug("deleting customer ${userId} price ${planItemId}")

            webServicesSession.deleteCustomerPrice(userId, planItemId)

            flash.message = 'deleted.customer.price'
            flash.args = [ params.itemId as String ]

        } catch (SessionInternalError e) {
            viewUtils.resolveException(flash, session.locale, e)
        }

        // render remaining prices for the priced product
        productPrices(params: [id: params.itemId, userId: userId])
    }

    def retrieveCurrencies() {
        def currencies = new CurrencyBL().getCurrencies(session['language_id'].toInteger(), session['company_id'].toInteger())
        return currencies.findAll { it.inUse }
    }

}
