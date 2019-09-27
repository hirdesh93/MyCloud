public with sharing class ContactRelatedAccount {
    
    @AuraEnabled
    public static  Contact getContact(ID conId){
        return [select id ,Name, LastName , AccountId, Account.Name , Account.Industry from contact where Id =: conId];
    } 
}