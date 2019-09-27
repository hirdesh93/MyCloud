public with sharing class createaccountnew{
    public id accID{get;set;}
    @AuraEnabled
    public static Account saveAccount (Account acc) {
      //  acc=[select id ,Name,Industry from account where Id =: accID]
        insert acc;
        return acc;
    }
}