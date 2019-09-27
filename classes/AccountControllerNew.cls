public with sharing class AccountControllerNew{
    @AuraEnabled
    
    public static Account saveAccount (Account acc) {
        
        upsert acc;
        return acc;
    }
}