@istest
private class TestAccountHandler {
    @istest
    static void testme(){
        
        Account acc= new Account();
        acc.Name = 'hirdesh';
        insert acc;

        AccountHandler.insertNewAccount('hirdesh');  
        AccountHandler.insertNewAccount(null);
    }

}