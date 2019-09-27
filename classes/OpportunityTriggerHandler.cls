/*
This class handles all trigger events on Opportunity Object
--------------------------------------------------------------------------------------
Version#     Date                           Author                    Description
--------------------------------------------------------------------------------------
1.0          06-Sep-2017                    Shubham Awasthi           Initial Version
--------------------------------------------------------------------------------------
*/
public class OpportunityTriggerHandler implements ITriggerHandler {

    //Interface methods starts here
    public Boolean IsDisabled(){ 
        return ConstantsUtility.IsTriggerDisabled('OpportunityTrigger');    //Checks to see if the trigger has been disabled
    }
    
    
    
    public void BeforeInsert(List<SObject> triggerNew) 
    {
        //dummy code
        //test();
        // REIB Methods
     //   updateRecordType(triggerNew);
       // populateUserManagerEmail(triggerNew, null);
        
        // D&S Methods
       // populateProjectName(triggerNew,null); 
       // updateDeveloperAccountEmail(triggerNew,null);      
       // updateStagename(triggerNew);
       // UpdateCPEmailonlead(triggerNew, null);
         //updateRecTypeOnOpportunity(triggerNew);          
        
    }
    public void BeforeUpdate(List<SObject> triggerNew, Map<Id, SObject> triggerOldMap) 
    {        
        // REIB Methods
        //updateOpportunityApprovalStatus(triggerNew,triggerOldMap);
        //populateUserManagerEmail(triggerNew,triggerOldMap);
        //updateOppDetailOnFeeApproval(triggerNew, triggerOldMap);
        //ResetApprovalAndRejectionPercentAndCount(triggerNew,triggerOldMap);     
       // UpdateOnHoldDate(triggerNew,triggerOldMap);
        //ValidateOppForProspect(triggerNew,triggerOldMap);    //=========  comented due to chnage in opp to opp tagging process
        //updateOpptyBlockingReason(triggerNew,triggerOldMap);
        
        // D&S Methods
     /*   updateRegistrationDate(triggerNew,triggerOldMap);
        populateProjectName(triggerNew,triggerOldMap);
        populateBlockedDate(triggerNew,triggerOldMap);
        populateDocumentReceivedDate(triggerNew,triggerOldMap);
        populateCheque_DDReceivedDate(triggerNew,triggerOldMap);
        populateDocVerifyAndCheRealizeExpDate(triggerNew,triggerOldMap);
        updateOppStageToBooking(triggerNew,triggerOldMap);
        updateOppStageToBooked(triggerNew,triggerOldMap);
        updateIsProspectRatingValueOnOpportunity(triggerNew,triggerOldMap);
        ChangeOppOwnerWhenStageIsBooked(triggerNew,triggerOldMap);
        UpdateSiteVisitSource(triggerNew,triggerOldMap);
        updateCPSelectiondate(triggerNew,triggerOldMap);
        updateWalkinCP(triggerNew,triggerOldMap);
        checkBookingSourceAndSubSourcesPopulated(triggerNew,triggerOldMap);
        updateSetToNullOppStage(triggerNew,triggerOldMap);
        UpdateCPEmailonlead(triggerNew,triggerOldMap);  
        updateForfietRefundAmount(triggerNew,triggerOldMap);
        updateCPCommissionAmt(triggerNew,triggerOldMap);*/
    }
    
    public void BeforeDelete(List<SObject> triggerOld) {}
    public void AfterInsert(List<SObject> triggerNew) 
    {
        // REIB Methods
      //  createProspectOpportunity(triggerNew);
    }
    public void AfterUpdate(List<Sobject> triggerNew, Map<Id, Sobject> triggerOldMap) 
    {
        // REIB Methods
      /*  UpdateOpportunityTATValuesFromTAT(triggerNew,triggerOldMap);        
        updateProspectLeadOrOpprtunity(triggerNew, triggerOldMap);    //=========  comented due to chnage in opp to opp tagging process
        makeTrackwizzCallout(triggerNew, triggerOldMap);     */  
        
        // D&S Methods  
             
      /*  updateCampaignBooked(triggerNew, triggerOldMap);
        updateTotalRevCampaign(triggerNew, triggerOldMap);
        submitOppForSiteVisitSourceApproval(triggerNew, triggerOldMap);
        createCPAccural(triggerNew, triggerOldMap);*/
        /* Special Notes
           UpdateBypassValidationToFalse method will be called at end of after Update.
           Please write any your methods above this 
         */
     //   UpdateBypassValidationToFalse(triggerNew);
    }
    public void AfterDelete(List<SObject> triggerOld) {}
    public void AfterUndelete(List<SObject> triggerOld) {}

    
    /* =======================================  REIB Methods  =========  Start  ===========================================================================*/
        
    /*
    //  
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          24-Oct-2017                    Dushyant Pratap Singh                Initial Version    
    --------------------------------------------------------------------------------------
    @params      list<opportunity> triggerNew,Map<Id, SObject> triggerOldMap
    @output      void
    --------------------------------------------------------------------------------------
    

     private void ValidateOppForProspect(list<opportunity> triggerNew, Map<Id, SObject> triggerOldMap)
    {
        set<Id> setOfCustomerOpp = new set<Id>();
         map<id,lead> mapLead = new map<id,lead>();
         map<id,Prospect_Opportunity__c> mapProcpectOpp = new map<id,Prospect_Opportunity__c>();
         
        for(opportunity objOpp : triggerNew){      
            opportunity objOpp_Old = triggerOldMap != null ? (opportunity)triggerOldMap.get(objOpp.id): null;
            if(objOpp_Old != null && objOpp_Old.StageName == 'Identifying Potential Prospect' && objOpp.StageName == 'Prospect finalized'){
                setOfCustomerOpp.add(objOpp.id);
            }            
        }
        if(!setOfCustomerOpp.isEmpty())
        {
            for(lead objLead : [select id,Prospect_Opportunity__c from Lead where status = 'Finalized' AND Prospect_Opportunity__c in:setOfCustomerOpp]){
                mapLead.put(objlead.Prospect_Opportunity__c, objlead);
            }
            
             for(Prospect_Opportunity__c  objCopp : [select id,Customer_Opportunity__c,Prospect_Opportunity__c,REIB_Approval_Status__c from Prospect_Opportunity__c where Status__c = 'Prospect finalized' AND (Customer_Opportunity__c in:setOfCustomerOpp OR Prospect_Opportunity__c in:setOfCustomerOpp)]){
                mapProcpectOpp.put(objCopp.Customer_Opportunity__c,objCopp);
                mapProcpectOpp.put(objCopp.Prospect_Opportunity__c,objCopp);
            }
            
            
            for(opportunity objOpp : triggerNew){
            if(!mapLead.containskey(objOpp.id) && !mapProcpectOpp.containskey(objOpp.id))
                objOpp.addError(Label.Prospect_Finalized_Validation_Message);
            }
        }
    }*/
    
    
      /*
    //This method is used to Apporval status from approve to draft when opportunity stage is change
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          06-Sep-2017                    Dushyant pratap singh              Initial Version    
    --------------------------------------------------------------------------------------
    @params      list<opportunity> triggerNew,Map<Id, SObject> triggerOldMap
    @output      void
    --------------------------------------------------------------------------------------
    */
    private void updateOpportunityApprovalStatus(list<opportunity> triggerNew, Map<Id, SObject> triggerOldMap)
    {       
        for(opportunity objOpp : triggerNew)
        {
            opportunity objOpp_Old = triggerOldMap != null ? (opportunity)triggerOldMap.get(objOpp.id) : null;
            
       /*     if(objOpp_Old != null && objOpp_Old.StageName != objOpp.StageName && objOpp_Old.Opportunity_Approval_Status__c == 'Approved')
            {
                objOpp.Opportunity_Approval_Status__c = 'Draft';
            }*/
        }
    }
    
    /*
    //This method is used to populate User manager email
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          09-Oct-2017                    Dushyant pratap singh                Initial Version    
    --------------------------------------------------------------------------------------
    @params      list<opportunity> triggerNew, Map<Id, SObject> triggerOldMap
    @output      void
    --------------------------------------------------------------------------------------
    */
    private void populateUserManagerEmail(list<opportunity> triggerNew, Map<Id, SObject> triggerOldMap)
    {
        set<id> setOwnerIds = new set<id>();
        map<id,string> mapOwnerIdToManagerEmail = new map<id,string>();
        for(opportunity objOpp : triggerNew)
        {
            setOwnerIds.add(objOpp.OwnerId);
        }
        
        if(!setOwnerIds.isEmpty())
        {
            for(User oUser : [select Id,Manager.email from user where id in:setOwnerIds AND ManagerId != null])
            {
                mapOwnerIdToManagerEmail.put(oUser.Id,oUser.Manager.email);
            }
        }
        
        for(opportunity objOpp : triggerNew)
        {
           // objOpp.Manager_Email__c = mapOwnerIdToManagerEmail != null && mapOwnerIdToManagerEmail.containsKey(objOpp.OwnerId) ? mapOwnerIdToManagerEmail.get(objOpp.OwnerId) : null;
        }
    }
    
    
    /*
    //This method is used to update the opportunity according to bussiness unit
    --------------------------------------------------------------------------------------
    Version#     Date                           Author                    Description
    --------------------------------------------------------------------------------------
    1.0          06-Sep-2017                    Shubham Awasthi                Initial Version    
    --------------------------------------------------------------------------------------
    @params      list<opportunity> triggerNew
    @output      void
    --------------------------------------------------------------------------------------
    */
      
}