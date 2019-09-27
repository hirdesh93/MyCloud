@istest
private class TestConfirmationEmail {
	@istest
    static void show(){
        Session__c sess = new Session__c();
        sess.Description__c='test description';
        sess.Name='test';
        sess.Level__c='Beginner';
        sess.Session_Date__c=system.now();
        insert sess;
        
        Speaker__c spek = new Speaker__c();
        spek.Bio__c='test bio';
        spek.Email__c='test@test.com';
        spek.First_Name__c='test first';
        spek.Last_Name__c='test Last';
        insert spek;
        
        Session_Speaker__c ssc = new Session_Speaker__c();
        ssc.Session__c=sess.Id;
        ssc.Speaker__c=spek.id;
        insert ssc;
        
        
        
    }

}