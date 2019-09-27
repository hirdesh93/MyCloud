trigger ContactMapWithAccount on Contact (before insert ,before update) {
    if(trigger.isbefore && (trigger.isInsert || trigger.isupdate)){
        string ConEmail ;
        Map<string,String> conMap = new Map<string,String>();
        for(contact con : trigger.new){
            ConEmail = con.email;
        }
        if(string.isNotBlank(ConEmail)){
            Account Acc = [select id , name  from Account where Hirdesh93Org__Email__c =: ConEmail limit 1];
            
            if(conMap.isEmpty())
                conMap.put(ConEmail, Acc.Id);
        }
        for(Contact con : Trigger.new){
            if(!conMap.isEmpty()){
                con.AccountId = conMap.get(con.Email);
            }
        }
    }
}