public class AccountInlineEditCLs {
    public List<account> acclst=new List<account>();
    public string accId {get;set;}
    public Account acc {get;set;}
    public List<account> getAccounts(){
        acc = new Account();
        acclst=[select name,industry,type,Description from account];
        return acclst;
    }
    public void Fetchdta(){
        acc = [select id, name , Industry,Type from account where Id =:accid limit 1];
        
    }
    public void save1() {
        acc = [select id, name from account where Id =:accid limit 1];
        Update acc;
        System.debug('TestData'+ accId +' --' +acc);
    }
}