trigger OpportunityTriggera on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    //delegating trigger execution to handler class
    TriggerDispatcher.Run(new OpportunityTriggerHandler());
}