trigger BadgePopulateNew on Enrollment__c (after insert , after update) {
    if((trigger.isinsert || trigger.isupdate) && trigger.isafter){
        triggerHandlerEnrollment tr = new triggerHandlerEnrollment();
           tr.BadgePopulate(trigger.new, trigger.oldMap);
    }

}