@istest
private class TestReminderEmail {
	@istest
    static void testme(){
        Test.startTest();
			String query; 
            String subject; 
            String body;
        SendReminderEmail b1 = new SendReminderEmail(query,subject,body);
        Speaker__c sp= new Speaker__c();
        sp.First_Name__c='test';
        sp.Email__c='hirdesh@test.com';
        insert sp;
        List<Speaker__c> scope= new List<Speaker__c>();
        Database.BatchableContext bc;
        try{
        b1.execute(bc, scope);
        b1.start(bc);
        b1.finish(bc);
        }Catch(exception e){
            
        }
        Test.stopTest();
    }
}