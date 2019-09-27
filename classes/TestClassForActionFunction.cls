@istest
private class TestClassForActionFunction {
    static testMethod void myUnitTest(){
        Account acc= new Account();
        acc.Name='Hirdesh';
        insert acc;       
        test.startTest();
        ClassForActionFunction afr= new ClassForActionFunction();
   		afr.Save();
        test.stopTest();
       }
}