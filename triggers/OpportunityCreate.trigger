trigger OpportunityCreate on Opportunity (After insert) {
    if (trigger.isinsert && trigger.isAfter){
        List<Book_Category__c> oppList = new List<Book_Category__c>();
        for(Opportunity opp : trigger.new){
            if(opp.stageName == 'Closed Won'){
                Book_Category__c bcc = new Book_Category__c();
                bcc.Name = opp.Name;
                bcc.Descriptions__c = opp.StageName;
                bcc.Discount__c = opp.Amount;
             	oppList.add(bcc);   
            }
           
        }
        insert oppList;
    }
    
}