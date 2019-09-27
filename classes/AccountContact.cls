public class AccountContact {
    public Apexpages.StandardSetController Controller{get;set;}
    public Contact cont {get;set;}
    public string  crid {get;set;}
    Public list<Account> getList(){
        List<Account> acclist=(List<Account>)Controller.getRecords();
        return acclist;
    }
    
    public AccountContact(){
        cont = new Contact();
        List<Account> aList= [select id, name from account];
        // List<Contact> cList= [select id, FirstName,LastName, accountId From Contact where AccountId In: aList];
        controller=new Apexpages.StandardSetController(aList);
        Controller.SetPageSize(5);
    }
 //  https://stackoverflow.com/questions/11891065/css-only-scrollable-table-with-fixed-headers
    public string Name			{get;set;}
    public string q				{get;set;}
    public string d				{set;get;}
    public list<Account> acc    {get;set;}
    public List<Contact> con 	{get;set;}
    public list<Contact> con1 = new List<Contact>();
    public list<Contact> con2 = new List<Contact>();
    
    public void search(){
        q='select id,name from Account';
        q=q+' where name=\''+Name+'\'';
        acc=database.query(q);
        d='select FirstName,LastName from contact where AccountId in:acc';
        con=Database.query(d);
    }
    Public List<Contact> conList {get;set;}
    public void deletecon(){
        crid = Apexpages.currentpage().getParameters().get('recidval');
        conList =[select id, FirstName, LastName from Contact where Id =:crid];
        system.debug(conList);
        delete conList;
        con=Database.query(d);
    }
    public static void sendMail(String address, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
  /*  public void search(){
        // search all the contacts related to Particular Account
        conList =[select id,firstname,lastname,phone,email, AccountId from contact Where AccountId =: cont.AccountId];
        system.debug(conList); 
    }*/
}