@istest
private class TestBatch1 {
    testmethod static void testme(){
        Account acc= new account();
        acc.Name='hiji';
        insert acc;
        test.startTest();
        batch1 b= new batch1();
        Database.executeBatch(b);
        test.stopTest();
        
    }
    

}