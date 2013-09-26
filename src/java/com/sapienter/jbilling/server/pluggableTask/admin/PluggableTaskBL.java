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

package com.sapienter.jbilling.server.pluggableTask.admin;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.iterators.ArrayListIterator;
import org.apache.log4j.Logger;

import com.sapienter.jbilling.common.SessionInternalError;
import com.sapienter.jbilling.server.pluggableTask.PluggableTask;
import com.sapienter.jbilling.server.util.Constants;
import com.sapienter.jbilling.server.util.Context;
import com.sapienter.jbilling.server.util.audit.EventLogger;

public class PluggableTaskBL<T> {
    private static final Logger LOG = Logger.getLogger(PluggableTaskBL.class);     
    private EventLogger eLogger = null;

    private PluggableTaskDAS das = null;
    private PluggableTaskParameterDAS dasParameter = null;
    private PluggableTaskDTO pluggableTask = null;
    
    public PluggableTaskBL(Integer pluggableTaskId) {
        init();
        set(pluggableTaskId);
    }
    
    public PluggableTaskBL() {
        init();
    }
    
    private void init() {
        eLogger = EventLogger.getInstance();        
        das = (PluggableTaskDAS) Context.getBean(Context.Name.PLUGGABLE_TASK_DAS);
        dasParameter = new PluggableTaskParameterDAS();
    }

    public void set(Integer id) {
        pluggableTask = das.find(id);
    }
    
    public void set(Integer entityId, Integer typeId) {
        pluggableTask = das.findByEntityType(entityId, typeId);
    }

    public void set(PluggableTaskDTO task) {
        pluggableTask = task;
    }

    public PluggableTaskDTO getDTO() {
        return pluggableTask;
    }
    
    public int create(Integer executorId, PluggableTaskDTO dto) {
        validate(dto);
        LOG.debug("Creating a new pluggable task row " + dto);
        pluggableTask = das.save(dto);
        eLogger.audit(executorId, null, Constants.TABLE_PLUGGABLE_TASK, 
                pluggableTask.getId(), EventLogger.MODULE_TASK_MAINTENANCE,
                EventLogger.ROW_CREATED, null, null, null);
        
        return pluggableTask.getId();
    }
    
    public void createParameter(Integer taskId, 
            PluggableTaskParameterDTO dto) {
        PluggableTaskDTO task = das.find(taskId);
        dto.setTask(task);
        task.getParameters().add(dasParameter.save(dto));

        // clear the rules cache (just in case this plug-in was ruled based)
        PluggableTask.invalidateRuleCache(taskId);
    }
    
    public void update(Integer executorId, PluggableTaskDTO dto) {
        if (dto == null || dto.getId() == null) {
            throw new SessionInternalError("task to update can't be null");
        }
        validate(dto);

        List<PluggableTaskParameterDTO> parameterDTOList = dasParameter.findAllByTask(dto);
        for (PluggableTaskParameterDTO param: dto.getParameters()) {
            parameterDTOList.remove(dasParameter.find(param.getId()));
            param.expandValue();
        }

        for (PluggableTaskParameterDTO param: parameterDTOList){
            dasParameter.delete(param);
        }

        LOG.debug("updating " + dto);
        pluggableTask = das.save(dto);
        
        eLogger.audit(executorId, null

                , Constants.TABLE_PLUGGABLE_TASK,
                dto.getId(), EventLogger.MODULE_TASK_MAINTENANCE,
                EventLogger.ROW_UPDATED, null, null, null);
        // clear the rules cache (just in case this plug-in was ruled based)
        PluggableTask.invalidateRuleCache(dto.getId());
        das.invalidateCache(); // 3rd level cache

        pluggableTask.populateParamValues();
    }
    
    public void delete(Integer executor) {
        eLogger.audit(executor, null, Constants.TABLE_PLUGGABLE_TASK, 
                pluggableTask.getId(), EventLogger.MODULE_TASK_MAINTENANCE,
                EventLogger.ROW_DELETED, null, null, null);
        das.delete(pluggableTask);
        // clear the rules cache (just in case this plug-in was ruled based)
        PluggableTask.invalidateRuleCache(pluggableTask.getId());
    }

    public void deleteParameter(Integer executor, Integer id) {
        eLogger.audit(executor, null, Constants.TABLE_PLUGGABLE_TASK_PARAMETER, 
                id, EventLogger.MODULE_TASK_MAINTENANCE,
                EventLogger.ROW_DELETED, null, null, null);
        PluggableTaskParameterDTO toDelete = dasParameter.find(id);
        toDelete.getTask().getParameters().remove(toDelete);
        // clear the rules cache (just in case this plug-in was ruled based)
        PluggableTask.invalidateRuleCache(toDelete.getTask().getId());
        dasParameter.delete(toDelete);
    }


    public void updateParameters(PluggableTaskDTO dto) {

        // update the parameters from the dto
        for (PluggableTaskParameterDTO parameter: dto.getParameters()) {
            updateParameter(parameter); 
        }
    }
    
    private void updateParameter(PluggableTaskParameterDTO dto) {
        dto.expandValue();
        dasParameter.save(dto);
        // clear the rules cache (just in case this plug-in was ruled based)
        PluggableTask.invalidateRuleCache(dto.getTask().getId());
    }
    
    public T instantiateTask()
            throws PluggableTaskException {

        PluggableTaskDTO localTask = getDTO();
        String fqn = localTask.getType().getClassName();
        T result;
        try {
            Class taskClazz = Class.forName(fqn);
                    //.asSubclass(result.getClass());
            result = (T) taskClazz.newInstance();
        } catch (ClassCastException e) {
            throw new PluggableTaskException("Task id: " + pluggableTask.getId()
                    + ": implementation class does not implements PaymentTask:"
                    + fqn, e);
        } catch (InstantiationException e) {
            throw new PluggableTaskException("Task id: " + pluggableTask.getId()
                    + ": Can not instantiate : " + fqn, e);
        } catch (IllegalAccessException e) {
            throw new PluggableTaskException("Task id: " + pluggableTask.getId()
                    + ": Can not find public constructor for : " + fqn, e);
        } catch (ClassNotFoundException e) {
            throw new PluggableTaskException("Task id: " + pluggableTask.getId()
                    + ": Unknown class: " + fqn, e);
        }

        if (result instanceof PluggableTask) {
            PluggableTask pluggable = (PluggableTask) result;
            pluggable.initializeParamters(localTask);
        } else {
            throw new PluggableTaskException("Plug-in has to extend PluggableTask " + 
                    pluggableTask.getId());
        }
        return result;
    }
    
    private void validate(PluggableTaskDTO task) {
        List<ParameterDescription> missingParameters = new ArrayList<ParameterDescription>();
        try {
            // start by getting an instance of this type
            PluggableTask instance = (PluggableTask) PluggableTaskManager.getInstance(
                    task.getType().getClassName(), task.getType().getCategory().getInterfaceName());
            
            // loop through the descriptions of parameters
            for (ParameterDescription param: instance.getParameterDescriptions()) {
                if (param.isRequired()) {
                    if(task.getParameters()== null || task.getParameters().size() == 0) {
                        missingParameters.add(param);
                    } else {
                        boolean found = false;
                        for (PluggableTaskParameterDTO parameter:task.getParameters()) {
                            if (parameter.getName().equals(param.getName()) && parameter.getStrValue() != null &&
                                    parameter.getStrValue().trim().length() > 0) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            missingParameters.add(param);
                        }
                    }
                }
            }
        } catch (PluggableTaskException e) {
            LOG.error("Getting instance of plug-in for validation", e);
            throw new SessionInternalError("Validating plug-in");
        }
        
        if (missingParameters.size() > 0) {
            SessionInternalError exception = new SessionInternalError("Validation of new plug-in");
            String messages[] = new String[missingParameters.size()];
            int f=0;
            for (ParameterDescription param: missingParameters) {
                messages[f] = new String("PluggableTaskWS,parameter,plugins.error.required_parameter," + param.getName());
                f++;
            }
            exception.setErrorMessages(messages);
            throw exception;
        }
        
        // now validate that the processing order is not already taken
        boolean nonUniqueResult= false;
    	try {
    	    PluggableTaskDTO samePlugin = das.findByEntityCategoryOrder(task.getEntityId(), task.getType().getCategory().getId(), 
                    task.getProcessingOrder());
    	    if (samePlugin != null && !samePlugin.getId().equals(task.getId())) {
    	        nonUniqueResult=true;
    	    }
    	} catch (Exception e) {
    	    nonUniqueResult=true;
    	}
        if (nonUniqueResult) {
            SessionInternalError exception = new SessionInternalError("Validation of new plug-in");
            exception.setErrorMessages(new String[] {
                    "PluggableTaskWS,processingOrder,plugins.error.same_order," + task.getProcessingOrder()});
            throw exception;
        }
    }
 
}
