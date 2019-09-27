public with sharing class RelatedListController { 
    public boolean flag {get;set;}    
    public List<Field_Analyse__c> FieldList {get;set;}
    public RelatedListController(ApexPages.StandardController controller) {
        flag = false;
        FieldList = new List<Field_Analyse__c>();
        FieldList = DataBase.Query('select id,name,Populated_On_Percent__c,Field_API_Name__c,Populated_On__c,Field_Length__c,Type__c from Field_Analyse__c where Field_Tracking__r.Batch_Processed__c=true and Field_Tracking__c=\''+String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'))+'\'');
        if(FieldList.size() >0){
            flag = true;
        }
    }   
}