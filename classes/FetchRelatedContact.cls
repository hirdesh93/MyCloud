public class FetchRelatedContact {
    public list<selectoption> AllAccount 	{ get; set; }
    public list<contact> contacts 			{ get; set; }
    public String selVal 					{ get; set; }
    
    public FetchRelatedContact(){
        Allaccount = new list<selectoption>();
        list<account> acnts = [select id, name from account];
        for(account ac :acnts){
            allaccount.add(new selectoption(ac.id,ac.name));
        }
     }
    public void showRelatedContacts(){
        contacts = [select name,email from contact where accountid = :selVal];
     }
}