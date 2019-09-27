/*
This class is used to bundle all common logic
--------------------------------------------------------------------------------------
Version#     Date                           Author                    Description
--------------------------------------------------------------------------------------
1.0          06-Sep-2017                    Shubham Awasthi           Initial Version
--------------------------------------------------------------------------------------
*/
public class ConstantsUtility{    
    /*
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          06-Sep-2017                    Shubham Awasthi           This method is used to check whether Trigger is Disabled or not
    --------------------------------------------------------------------------------------
    @params      triggerName
    @output      true/false
    --------------------------------------------------------------------------------------
    */
    public static boolean IsTriggerDisabled (string triggerName){
    
        if(string.isNotBlank(triggerName)){
         //   Trigger_Settings__c objTriggerSetting = Trigger_Settings__c.getValues(triggerName);
          //  if(objTriggerSetting == null)
                return true;
           // return objTriggerSetting.Is_Trigger_Disabled__c;
        }
        else
            return true;
    }
    /*
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          30-Oct-2017                    Vanshraj           This method is used to check 
                                                                   whether Cooldown Period Under/Outside 
                                                                   is true or false
    --------------------------------------------------------------------------------------
    @params      Existing Lead Object
    @output      true/false
    --------------------------------------------------------------------------------------
    */
    public static boolean IsCheckUnderOutSideCooldownPeriod(lead objLead){
        boolean Ischeck;
        if(objLead != null){
           /* if(objLead.Cooldown_Period__c != null){
                Date leadCreatedDt = Date.valueOf(objLead.CreatedDate);
                Date TodayDt = system.today();
                integer leadDiffDate = leadCreatedDt.daysBetween(TodayDt);
                //Checked Under Cooldown Period 
                if(leadDiffDate <= objLead.Cooldown_Period__c){
                   Ischeck = true;
                }
                //Checked Outside Cooldown Period
                 else{
                    Ischeck = false;
                }
            }*/
        }
        return IsCheck; 
    }
}