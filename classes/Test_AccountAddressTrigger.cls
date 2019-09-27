@istest
private class Test_AccountAddressTrigger {
	@istest
    static void testmethodshow(){
        Account acc = new Account(Name='TestPrimayContact', Industry = 'Aviation', Type='Prospect' );
        insert acc;
        Account ac1 = [select id from Account where name = 'TestPrimayContact'];
        ac1.Name='test';
        update ac1;
        
    }
}