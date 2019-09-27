public class AccountController1 {
    ApexPages.StandardController asp;
    Account acc;
    List<Account> acclist= new List<Account>();
    List<Contact> conlist= new List<Contact>();
    Set<String> accIds= new Set<String>();
    public AccountController1(ApexPages.StandardController Controller){
     Account acc=(Account)Controller.getRecord();
        asp=Controller;
    }
    public List<Contact> getCont(){
        acc= (Account)asp.getRecord();
        conlist.clear();
        accIds.clear();
        acclist.clear();
        if(acc.Name<>null){
            acclist=[select id, name From account where Name=:acc.Name];
        }
        for(integer i=0;i<acclist.size();i++){
            accIds.add(acclist[i].Id);
     }
        conlist=[select id,Name,Phone,AccountId from Contact where AccountId In :accIds];
        return conlist;
    }
    public pageReference find(){
        conlist=[select id,Name,Phone,AccountId from Contact where AccountId In :accIds];
        
        return null;
    }

}