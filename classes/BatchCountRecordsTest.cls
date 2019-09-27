@istest(SeeAllData=true)
public class BatchCountRecordsTest {
     static testmethod void unit1(){
        
        Field_Tracking__c ft = new Field_Tracking__c ();
        ft.Object_Name__c = 'Account';
        ft.name = 'test';
        // ft.Batch_Processed__c = true;
        insert ft;
        
        Field_Analyse__c  fa = new Field_Analyse__c ();
        fa.Field_Tracking__c = ft.Id;
        fa.name = 'Name';
        fa.Field_API_Name__c = 'Name';
        fa.Field_Length__c = 255;
        fa.Type__c  = 'string';
        insert fa;
        
        fa.Populated_On__c = 10;
        update fa;
        
        ft.Batch_Processed__c = true;
        update ft;     
         
        List<Field_Analyse__c> flist = new List<Field_Analyse__c>();
        flist.add(fa);
         
        BatchCountRecords batchcountrec = new BatchCountRecords(ft.Object_Name__c ,ft.name ,ft.Id);
        database.executeBatch(batchcountrec,50);
     //   batchcountrec.execute(new Database.BatchableContext(),flist);
        
    }
}