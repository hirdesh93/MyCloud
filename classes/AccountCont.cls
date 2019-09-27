public with sharing class AccountCont {
    @AuraEnabled
    public static List<Account> getAccounts() {
        List<Account> acc=[SELECT Id, Name, Industry,CreatedDate FROM Account ];
        return acc;
    }
    @AuraEnabled
    public Void getacc(){
        String Name;
        list<Account> acc ;
        String q ='select id,name from Account';
            q=q+' where name=\''+Name+'\'';
        acc=database.query(q);
    }
    
}