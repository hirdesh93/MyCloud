public with sharing class CreateCandidateRecord {
    
    /**
* Create a new candidate Record
*
* @param Candidate__c candidate  candidate record to be inserted
* 
*/
    @auraenabled
    public static Id creatcandidateRecord(Hirdesh93Org__Candidate__c candidate){
        upsert candidate;
        return candidate.id;
    }
    
    @AuraEnabled
    public static void createRecord (Hirdesh93Org__Candidate__c candidate){
        try{
            System.debug('CreateCandidateRecord::createRecord::candidate'+candidate);
            insert candidate;
            system.debug('firstname'+candidate.Hirdesh93Org__First_Name__c);
            system.debug('firstname'+candidate.Hirdesh93Org__Last_Name__c);
            
        } catch (Exception ex){
        }    
    }    
}