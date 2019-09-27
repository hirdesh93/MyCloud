@istest
private class TestOlderAccountUtility {
	@istest
    static void show(){
        Account acc= new Account();
        acc.Name='test';
        acc.Phone='1234';
        insert acc;
        acc.Phone='3421';
        update acc;
        OlderAccountsUtility.updateOlderAccounts();
        }
    }