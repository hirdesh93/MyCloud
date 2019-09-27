trigger OpportunityTrigger on Opportunity (after insert, after update) {
    TriggerHandlerOpportunity thc = new TriggerHandlerOpportunity();
    if(trigger.IsAfter){
        if(trigger.isInsert || trigger.isAfter){
            thc.updateAccountActivityHistory(trigger.new);   
        }
    }
}