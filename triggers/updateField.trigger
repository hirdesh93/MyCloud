trigger updateField on Student_Badge__c (after insert, after delete) {
    TriggerHandlerStudentBadge thStuBadge = new TriggerHandlerStudentBadge();
    if(trigger.isinsert && trigger.isafter){
        thStuBadge.onAfterInsertnew(trigger.new);
        thStuBadge.PointsToUpdate(trigger.new);
    }
    
    if(trigger.isdelete && trigger.isafter){
        TriggerHandlerStudentBadge.OnAfterDelete(trigger.old);
        thStuBadge.PointsToUpdate(trigger.old);
    }
}