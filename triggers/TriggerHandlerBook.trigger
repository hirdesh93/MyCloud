trigger TriggerHandlerBook on Book__c (after delete, after insert, after undelete, after update, 
                                        before delete, before insert, before update) {
    BookTriggerHandler  bth = new BookTriggerHandler();
    
    if(trigger.isinsert && trigger.isafter){
        bth.onAfterInsert(trigger.new);
        bth.onAfterInsertnew(trigger.new);
    }
    
    if(trigger.isbefore && trigger.isinsert || trigger.isupdate){
        bth.onBeforeInsertAndUpdate(trigger.new);
    }
    if(trigger.isafter && trigger.isinsert){
        bth.onAfterInsertnew(trigger.new);
    }
    if(trigger.isafter && trigger.isDelete){
        BookTriggerHandler.OnAfterDelete(trigger.old);
    }
}