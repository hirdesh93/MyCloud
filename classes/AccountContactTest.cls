@isTest
public class AccountContactTest {
    
    @testSetup static void setup() {
        // Create common test accounts
        Account testAccts = new Account();
        testAccts.Name = 'TestAccount';
        insert testAccts;        
    }
    
    @istest
    static void testme(){
        Account acct = [SELECT Id FROM Account WHERE Name='TestAccount' LIMIT 1];
        delete acct;
    }
    @istest
    static void testme1(){
        Account acct = [SELECT Id,Name FROM Account WHERE Name='TestAccount' LIMIT 1];
        system.assertEquals('TestAccount', acct.name);
    }
}