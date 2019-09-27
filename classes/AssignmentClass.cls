public class AssignmentClass {
    public list<Online_Purchase_Order__c> onp {get;set;}
    Public boolean flag{get;set;}
    public string input{get;set;}
    Public AssignmentClass(){
        flag = false;
    }
    
    public void doInit(){
        Account myAccount = new Account(Name='Acme');
        insert myAccount;
        
        // Get the base URL.
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('Base URL: ' + sfdcBaseURL );       
        
        // Get the URL for the current request.
        String currentRequestURL = URL.getCurrentRequestUrl().toExternalForm();
        System.debug('Current request URL: ' + currentRequestURL);        
        
        // Create the account URL from the base URL.
        String accountURL = URL.getSalesforceBaseUrl().toExternalForm() + 
            '/' + myAccount.Id;
        System.debug('URL of a particular account: ' + accountURL); 
        
        // Get some parts of the base URL.
        System.debug('Host: ' + URL.getSalesforceBaseUrl().getHost());   
        System.debug('Protocol: ' + URL.getSalesforceBaseUrl().getProtocol());
        
        // Get the query string of the current request.
        System.debug('Query: ' + URL.getCurrentRequestUrl().getQuery());
    } 
    public void  showdata(){
        
        onp = database.Query('select id, name, Address__c, Amount__c, Quantity__c,Active__c,PartyName__c,Order_Date__c,Product__c,Total_Amount__c,Purchase_Order_Line_Items__c from Online_Purchase_Order__c where name like '+'\''+'%'+input+'%'+'\''); 
    }
    
}