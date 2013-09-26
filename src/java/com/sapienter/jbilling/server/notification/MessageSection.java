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

package com.sapienter.jbilling.server.notification;

import java.io.Serializable;

public class MessageSection implements Serializable {
    private Integer section;
    private String content;
    
    public MessageSection(){}
    
    public MessageSection(Integer section, String content) {
        this.section = section;
        this.content = content;
    }
    
    
    /**
     * @return
     */
    public String getContent() {
        return content;
    }

    /**
     * @return
     */
    public Integer getSection() {
        return section;
    }

    /**
     * @param string
     */
    public void setContent(String string) {
        content = string;
    }

    public String toString() {
        return "section = " + section + " content = " + content;
    }
}
