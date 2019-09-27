trigger ContactTriggerHandler on Contact (after insert ,after update, after undelete , after delete,before insert, before update) {
    triggerHandlercontact thc = new triggerHandlercontact();
    if(trigger.IsAfter){
        if(trigger.isInsert || trigger.isUndelete || trigger.IsUpdate){
            thc.updateFieldOnAccount(trigger.new , trigger.oldMap);
            thc.updateFieldOnAccountNew(trigger.new);
        }
        
        if(trigger.isDelete){
            thc.updateFieldOnAccount(trigger.old , trigger.oldMap);
            thc.updateFieldOnAccountNew(trigger.old);
        }
    }
    if(trigger.IsBefore){
        if(trigger.isInsert || trigger.isUpdate){
            thc.duplicateContact(trigger.new);
            
            thc.AccountCreateByContact(trigger.new);
            
        }
    }
}