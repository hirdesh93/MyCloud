@istest
private class LeadProcessorTest {
	@istest
    private static void testmethods(){
        Lead l = new Lead();
        l.LastName = 'test';
        l.Company = 'testc';
        insert l;
        
        l.LeadSource = 'Dreamforce';
        update l;
       // test.startTest();
        database.BatchableContext bc;
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
      //  test.stopTest();
    }
}