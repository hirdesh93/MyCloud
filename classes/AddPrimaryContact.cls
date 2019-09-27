public class AddPrimaryContact implements Queueable{
    Contact con;
    String state;
    
    public AddPrimaryContact(Contact con, String state){
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext context){
        List<Account> accLIst = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> conList = new List<Contact>();
        for(Account acc : accLIst){
            Contact con1 = con.clone(false,false,false,false);
            con1.AccountId = acc.Id;
            conList.add(con1);
        }
        if(conList.size() >0){
            insert conList;
        } 
    }
}