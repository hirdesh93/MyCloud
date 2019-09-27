public with sharing class contactEditPageExtension {
    public Contact contact{get;set;}
    public contactEditPageExtension(ApexPages.StandardController controller) {
        contact = new Contact();
    }
    public void test(){
        contact.otherCountry  	=  contact.MailingCountry;
        contact.otherState  	=  contact.MailingState;
        contact.otherStreet  	=  contact.MailingStreet;
        contact.OtherPostalCode =  contact.MailingPostalCode;
        contact.OtherCity		=  contact.MailingCity;    
    }
    Public PageReference saveRecord(){
        insert contact;
        PageReference pr = new PageReference('https://myorgtestdomain-dev-ed.my.salesforce.com/'+contact.Id);
        pr.setRedirect(true);
        return pr;
    }
}