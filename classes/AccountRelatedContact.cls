public class AccountRelatedContact {
    public Contact cont {get;set;}
    Public Opportunity opp {get;set;}
    public string  crid {get;set;}
    public string  orid {get;set;}
    public Contact con {get;set;}
    public boolean check {get;set;}
    public string description {get;set;}
    public string conId {get;set;}
    public Id objSelectedStudentId {get;set;}


    public AccountRelatedContact(){
        //Load all the contacts
        opp = new Opportunity();
        cont = new contact();
        check  = false;
        description = '';
    }
    Public List<Contact> conList {get;set;}
    public void searchContacts(){
        // search all the contacts related to Particular Account
        conList =[select id,firstname,lastname,phone,email, AccountId from contact Where AccountId =: cont.AccountId];
        system.debug(conList); 
    }
    Public List<Opportunity> oppList {get;set;}
    public void searchOpportunity(){
        // search all the opportunity related to Particular Account
        oppList =[select id,Name, AccountId from Opportunity Where AccountId =: opp.AccountId];
    }
    public void deletecon(){ 
        // Delete current contact from List And Refresh List Of Contacts
        crid = Apexpages.currentpage().getParameters().get('recidval');
        con = [select id, FirstName, LastName from Contact where Id =:crid];
        delete con;
        conList =[select id,firstname,lastname,phone,email, AccountId from contact Where AccountId =: cont.AccountId];
    }
    public void deleteopp(){ 
        // Delete current contact from List And Refresh List Of Contacts
        orid = Apexpages.currentpage().getParameters().get('recidval');
        opp = [select id,Name from Opportunity where Id =:orid];
        delete opp;
        oppList =[select id,Name, AccountId from Opportunity Where AccountId =: opp.AccountId];
    }
    
    public void handlestudentCheckboxChange(){
    for(contact objStudent: [select id,firstname,lastname,phone,email, AccountId from contact ]){
       if(objStudent.Id == objSelectedStudentId){
          system.debug('-----This is the selected student record----'+objStudent);
       }
    }
}
    public PageReference updateContact(){
    if(check == true){
        List<Contact> conList1 = new List<Contact>();
         for(Contact con : [select id,firstname,lastname,phone,email, AccountId from contact where id =: objSelectedStudentId]){
             con.description = description;
             conList1.add(con);
         }
         update conList1;
         
         }
    pagereference pr = new pagereference('/apex/AccountRelatedContactvfPage');
    pr.setredirect(true);
    return pr;
    }
}