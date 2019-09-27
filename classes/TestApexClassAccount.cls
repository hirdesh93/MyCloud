public class TestApexClassAccount {
    List<Account> accList {get;set;}
    
    public TestApexClassAccount(){
        accList = [select id, name, phone from account];
    }

}