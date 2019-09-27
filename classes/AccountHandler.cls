public class AccountHandler {
    public void updateLatestContact(List<Account> accList ,Map<Id,Account> newMap , Map<Id,Account> oldMap){
        
    Map<Id,String> mappCRole = new map<Id,string>();
    Map<Id, Id> mappCRole1 = new map<Id,Id>();
    Map<Id, string> mapoppName = new Map<Id,string>();
    set<id> setAccid = new set<id>();
    if(trigger.isbefore && trigger.isUpdate){
        for(Account acc : accList){
            if(newMap.get(acc.Id).industry != oldMap.get(acc.Id).industry){
                setAccid.add(acc.id);
            }
            
        }
        if(setAccid.size() > 0){
            for(Contact con: [SELECT Id,AccountId, Name,(SELECT OpportunityId,Opportunity.name, Contact.Name,Contact.Email,Contact.Id,Contact.AccountId,ContactId,Role
                                                            FROM OpportunityContactRoles limit 1)
                                 FROM Contact where accountid =: setAccid ORDER BY CreatedDate asc limit 1]){
                                     for(OpportunityContactRole ocr : con.OpportunityContactRoles){
                                         mappCRole1.put(ocr.OpportunityId,con.AccountId );
                                         system.debug('test mappCRole1'+mappCRole1.get(con.id));
                                     }                      
           }
            for(opportunity opp: [SELECT Id,AccountId, Name,(SELECT OpportunityId,Opportunity.name, Contact.Name,Contact.Email,Contact.Id,Contact.AccountId,ContactId,Role
                                  FROM OpportunityContactRoles where IsPrimary = true limit 1)
                                  FROM opportunity where Id =: mappCRole1.keyset()  limit 1]){
                                      for(OpportunityContactRole ocr1 : opp.OpportunityContactRoles) {
                                          mapoppName.put(mappCRole1.get(opp.id), ocr1.Contact.Name);
                                      }                               
                      }
        }
        for(Account acc : accList){
                acc.InvoiceStatus__c = mapoppName.get(acc.id);
                system.debug('test'+ acc.InvoiceStatus__c);
        }
    }
    }
    

}