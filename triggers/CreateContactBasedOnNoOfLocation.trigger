trigger CreateContactBasedOnNoOfLocation on Account (after insert) {
    
    if(trigger.isInsert){
        
        List<Contact> conList = new List<Contact>();
        for(Account acc: trigger.new){
            if(acc.Hirdesh93Org__No_Of_Locations__c != null){
                for(integer i=1 ; i<=acc.Hirdesh93Org__No_Of_Locations__c ; i++){
                    Contact con = new Contact();
                    con.LastName = acc.Name;
                    con.AccountId = acc.id;
                    conList.add(con);
                } 
            }
        }
        if(conList.size() >0){
            insert conList;
        }
    }

}