public class ShowAllContacts {

 string accid= ApexPages.currentPage().getParameters().get('accid');

public list<Contact> contlist{get;set;}

public ShowAllContacts(){
  if(accid !=null )
  //contlist= [select id,firstname,lastname,phone,email from contact where accountid='0019000000wFr7E'];
  contlist= [select id,firstname,lastname,phone,email from contact where accountid=:accid];
  }
  
      public PageReference cancel() {
      URL currentURL = URL.getCurrentRequestUrl();
      system.debug('currentURL.getPath()->'+currentURL.getPath());
      account acc = new account();
       // Send the user to the detail page for the new account.
        PageReference acctPage = new PageReference('/'+accid);
        acctPage.setRedirect(true);
        
        return acctPage;

        
    }
    
}