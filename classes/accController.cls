public class accController {
    public string accid {get; set;}
    public Account SelectedAcc{get;set;}
    public list<selectoption> getaccountnames() {
        list<selectoption> accoptions = new list<selectoption>();
        for (account acc : [select id, name from account]){
            accoptions.add(new selectoption(acc.id, acc.name));
        }  
        return accoptions;
    } 
    public void  getDetails() {
        SelectedAcc = new Account();
        SelectedAcc = [SELECT id, Name, Phone FROM Account WHERE id=:accid ];
        
    }
}