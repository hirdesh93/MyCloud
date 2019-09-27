@istest
private class TestAccountAddressTrigger {
	@istest
    static void test(){
       		Account a1= new Account();
            a1.Name='Test';
            a1.Match_Billing_Address__c=true;
            a1.BillingPostalCode='123456';
            insert a1;
        
       Account a2=[select id, name from account where name='Test'];
       update a2;
            
        
        
    }
    
}