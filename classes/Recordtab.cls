public with Sharing class Recordtab 
{    
    
    public List<Field_Tracking__c> mem {get;set;}    
       
    public Recordtab()
    {
        mem = [SELECT id,Name,Object_Name__c,Batch_Processed__c,Custom__c,Fields__c FROM Field_Tracking__c];
    }
}