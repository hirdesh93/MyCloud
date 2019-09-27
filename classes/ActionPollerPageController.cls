public with sharing class ActionPollerPageController {
    
    public List<Contact> getContacts(){
        
        return [SELECT Id,firstname,LastName, Account.Name, CreatedDate, Phone , Email FROM contact Order BY CreatedDate DESC limit 10 ];
        
    }
    
    public void latestAccount(){
        
        getContacts(); 
        
    }
    
}