public with sharing class DoAnalysisController {    
    public boolean pollerBool {get;set;}
    public boolean underway  {get;set;}
    public String batchStatus {get;set;}
    public List<AsyncApexJob> aajlist {get;set;}
    public AsyncApexJob aaj {get;set;}
    public Field_Tracking__c TheRecord{get;set;}
    public String url {get;set;}
    public string batchprocessid {get;set;}     
    public List<Field_Analyse__c> FieldList {get;set;}    
    public DoAnalysisController(){
        pollerBool = false;
        FieldList = new List<Field_Analyse__c>();
        FieldList = DataBase.Query('select id,name,Populated_On_Percent__c,Field_API_Name__c,Populated_On__c,Field_Length__c,Type__c from Field_Analyse__c where Field_Tracking__r.Batch_Processed__c=true and Field_Tracking__c=\''+String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'))+'\'');
        url = '/'+ApexPages.currentPage().getParameters().get('id');
    }
    public void goAnalyze(){      
        TheRecord = DataBase.Query('select id,Object_Name__c,name from Field_Tracking__c where id =\''+String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'))+'\' ');
        batchprocessid = Database.executeBatch(new BatchCountRecords(TheRecord.Object_Name__c,TheRecord.name,TheRecord.ID)); 
        aajlist = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors,ExtendedStatus  FROM AsyncApexJob WHERE ID =: batchprocessid ];
        if(aajlist.size()>0){
            aaj = aajlist[0];
            pollerBool = true;
        }
    }
    public void checkBatchStatus() {        
        aajlist = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors,ExtendedStatus  FROM AsyncApexJob WHERE ID =: batchprocessid ];
        System.debug('$$$$$$$$$$$$$$'+batchprocessid );
        if(aajlist.size()>0){
            aaj = aajlist[0];        
            batchStatus = aajlist[0].Status;
            if(batchStatus == 'Completed') {
                FieldList = DataBase.Query('select id,name,Field_API_Name__c,Populated_On_Percent__c ,Populated_On__c,Field_Length__c,Type__c from Field_Analyse__c where Field_Tracking__c=\''+ApexPages.currentPage().getParameters().get('id')+'\'');
                pollerBool = false;
            } 
            else if(batchStatus == 'Aborted' || batchStatus == 'Failed') {
                pollerBool = false;
            }
            else{
                pollerBool = true;
            }
        }
    }
    public void getFields() {
        
    }
}