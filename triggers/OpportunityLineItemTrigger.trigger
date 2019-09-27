trigger OpportunityLineItemTrigger on OpportunityLineItem (after Insert , after Delete , after update) {
    OpportunityLineItemHandler otp = new OpportunityLineItemHandler ();
    if(trigger.Isafter){
        if(Trigger.isInsert){
            otp.updateFieldOnOpportunity(trigger.new);
        }
        if(trigger.isDelete){
            otp.updateFieldOnOpportunity(trigger.old);
        }
    }  
}