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


public interface PermissionConstants {
    // permissions
    //  all these have to by on synch with the permisssion table    
    
    // if the user can create other users specifing the user type
    public static final Integer P_USER_CREATE_TYPE = Integer.valueOf(7);
    // if the user can create other users of the following types
    public static final Integer P_USER_CREATE_TYPE_ROOT = Integer.valueOf(8);
    public static final Integer P_USER_CREATE_TYPE_CLERK = Integer.valueOf(9);
    public static final Integer P_USER_CREATE_TYPE_PARTNER = Integer.valueOf(10);
    public static final Integer P_USER_CREATE_TYPE_CUSTOMER = Integer.valueOf(11);
    // which fields are viable/editable when editing a user
    public static final Integer P_USER_EDIT_CHANGE_ENTITY = Integer.valueOf(12);
    public static final Integer P_USER_EDIT_CHANGE_TYPE = Integer.valueOf(13);
    public static final Integer P_USER_EDIT_VIEW_TYPE = Integer.valueOf(14);
    public static final Integer P_USER_EDIT_CHANGE_USERNAME = Integer.valueOf(15);
    public static final Integer P_USER_EDIT_CHANGE_PASSWORD = Integer.valueOf(16);
    public static final Integer P_USER_EDIT_CHANGE_LANGUAGE = Integer.valueOf(17);
    public static final Integer P_USER_EDIT_VIEW_LANGUAGE = Integer.valueOf(18);
    public static final Integer P_USER_EDIT_CHANGE_STATUS = Integer.valueOf(20);
    public static final Integer P_USER_EDIT_VIEW_STATUS = Integer.valueOf(21);
    public static final Integer P_USER_EDIT_CHANGE_CURRENCY = Integer.valueOf(81);
    public static final Integer P_USER_EDIT_VIEW_CURRENCY = Integer.valueOf(82);
    public static final Integer P_USER_EDIT_VIEW_CC = Integer.valueOf(134);
    public static final Integer P_USER_EDIT_CHANGE_BLACKLIST = Integer.valueOf(145);
    // links to edit a user contact/cc/ach, plus other user edit options etc
    public static final Integer P_USER_EDIT_LINKS = Integer.valueOf(114);
    // initial page, link to craete new user
    public static final Integer P_USER_CREATE = Integer.valueOf(115);
    // if a user can edit an item (changing data) otherwise view only
    public static final Integer P_ITEM_EDIT = Integer.valueOf(34);
    // if a user can see all the left option of an order (g.invoice, suspend, etc).
    public static final Integer P_ORDER_LEFT_OPTIONS = Integer.valueOf(108);
    // if a user can delete invoices
    public static final Integer P_INVOICE_DELETE = Integer.valueOf(113);
    //  if a user can modify payments (delete/edit)
    public static final Integer P_PAYMENT_MODIFY = Integer.valueOf(114);
    //  if a user can modify pluggable tasks info
    public static final Integer P_TASK_MODIFY = Integer.valueOf(137);
    
    // roles
    // to be on synch with the role table
    public static final Integer ROLE_INTERNAL = Integer.valueOf(1);
    public static final Integer ROLE_ROOT = Integer.valueOf(2);
    public static final Integer ROLE_CLERK = Integer.valueOf(3);
    public static final Integer ROLE_PARTNER = Integer.valueOf(4);
    public static final Integer ROLE_CUSTOMER = Integer.valueOf(5);
}
