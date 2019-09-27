@istest
private Class DoAnalysisControllerTest{
    static testmethod void DoAnalysisControllerT(){
        
        Field_Tracking__c ft = new Field_Tracking__c ();
        ft.Object_Name__c = 'Account';
        ft.name = 'test';
        //ft.Batch_Processed__c = true;
        insert ft;
        
        Field_Analyse__c  fa = new Field_Analyse__c ();
        fa.Field_Tracking__c = ft.Id;
        fa.name = 'name';
        fa.Field_API_Name__c = 'Name';
       // fa.Populated_On__c = 10;
        fa.Field_Length__c = 255;
        fa.Type__c  = 'string';
        insert fa;
        List<Field_Analyse__c> flist = new List<Field_Analyse__c>();
        flist.add(fa);
        
        fa.Populated_On__c = 10;
        update fa;
        
		ft.Batch_Processed__c = true;
        update ft;
        
        string fieldId = ApexPages.currentPage().getParameters().put('id' , ft.Id);
        PageReference pageRef = Page.DoAnalysis; 
        pageRef.getParameters().put('id', fieldId);        
        DoAnalysisController  doAnalyis = new DoAnalysisController();
        doAnalyis.url = ApexPages.currentPage().getParameters().put('id' , fa.Id);       
        ApexPages.currentPage().getParameters().put('id' , ft.Id);
        
        doAnalyis.goAnalyze();
        doAnalyis.batchStatus = 'completed';
        doAnalyis.checkBatchStatus();
        doAnalyis.getFields();
         
        
    }
    
}