@istest
private class DescibeDemoControllerTest {
 static testmethod void unit1(){
        
        Field_Tracking__c ft = new Field_Tracking__c ();
        ft.Object_Name__c = 'Account';
        ft.name = 'test';
        ft.Batch_Processed__c = true;
        insert ft;
        
        Field_Analyse__c  fa = new Field_Analyse__c ();
        fa.Field_Tracking__c = ft.Id;
        fa.name = 'test';
        fa.Field_API_Name__c = 'Account__c';
        fa.Populated_On__c = 10;
        fa.Field_Length__c = 255;
        fa.Type__c  = 'string';
        insert fa;
        
        DescibeDemoController dDemoCont = New DescibeDemoController();
        dDemoCont.selectedObject = 'Account';
        List<selectoption> newList = dDemoCont.getListObjectName();
        dDemoCont.Cancel();
        dDemoCont.showFields();
        dDemoCont.SaveRecords();
        
        PageReference pageRef = Page.DescribeFieldsvf; 
        
    }
}