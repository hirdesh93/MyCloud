public class ShowAccount {
    
    @AuraEnabled
    public static Account[] getsearch(){
    string Name;
    string q;
    list<Account> acc;
        q='select id,name from Account';
            q=q+' where name=\''+Name+'\'';
        acc=database.query(q);
        return acc;
    }

}