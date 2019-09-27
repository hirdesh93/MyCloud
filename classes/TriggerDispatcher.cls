/*
This class is responsible for making sure all of the applicable methods on your 
trigger handler are called, depending on the current trigger context. 
It also contains a check to make sure that the trigger has not been disabled. 
If the trigger has been disabled (more on this below), then the trigger events will not be fired
--------------------------------------------------------------------------------------
Version#     Date                           Author                    Description
--------------------------------------------------------------------------------------
1.0          06-Sep-2017                    Shubham Awasthi           Initial Version
--------------------------------------------------------------------------------------
*/
public class TriggerDispatcher {
    /*
        Call this method from your trigger, passing in an instance of a trigger handler which implements ITriggerHandler.
        This method will fire the appropriate methods on the handler depending on the trigger context.
    */
    public static void Run(ITriggerHandler handler)
    {
        // Check to see if the trigger has been disabled. If it has, return
        if (handler.IsDisabled())
            return;
        
        // Detect the current trigger context and fire the relevant methods on the trigger handler:
 
        // Before trigger logic
        if (Trigger.IsBefore )
        {
            if (Trigger.IsInsert)
                handler.BeforeInsert(trigger.new);
 
            if (Trigger.IsUpdate)
                handler.BeforeUpdate(trigger.new, trigger.oldMap);
 
            if (Trigger.IsDelete)
                handler.BeforeDelete(trigger.old);
        }
         
        // After trigger logic
        if (Trigger.IsAfter)
        {
            if (Trigger.IsInsert)
                handler.AfterInsert(Trigger.new);
 
            if (Trigger.IsUpdate)
                handler.AfterUpdate(trigger.new, trigger.oldMap);
 
            if (trigger.IsDelete)
                handler.AfterDelete(trigger.old);
 
            if (trigger.isUndelete)
                handler.AfterUndelete(trigger.new);
        }
    }
}