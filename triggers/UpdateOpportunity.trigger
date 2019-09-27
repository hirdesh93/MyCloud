trigger UpdateOpportunity on Project__c (before insert) {
    set<Id> setIds = new Set<Id>();
    Map<Id,Id> mappCRole = new map<Id,Id>();
  //  List<Project__c> prlist = new List<Project__c>();
    for(Project__c pr : trigger.new){
        if(pr.Contact__c != null)
            setIds.add(pr.Contact__c);
        
    }
     /*   if(setIds.size() > 0){
            for(contact con: [SELECT Id,AccountId , Name,(SELECT OpportunityId,Opportunity.name, Contact.Name,Contact.Email,Contact.Id,Contact.AccountId,ContactId,Role
                                                            FROM OpportunityContactRoles limit 1) FROM Contact where id In : setIds ]){
                                  for(OpportunityContactRole ocr : con.OpportunityContactRoles){
                                         mappCRole.put(ocr.ContactId , ocr.OpportunityId);
                                      system.debug('testMapRole' +mappCRole.get(ocr.ContactId));
                                      
                                     }                      
                              }
        } */
        for(Project__c pr1 : trigger.new){  
           if(setIds.size() > 0){
            for(contact con: [SELECT Id,AccountId , Name,(SELECT OpportunityId,Opportunity.name, Contact.Name,Contact.Email,Contact.Id,Contact.AccountId,ContactId,Role
                                                            FROM OpportunityContactRoles limit 1 ) FROM Contact where id In : setIds ]){
                                  for(OpportunityContactRole ocr : con.OpportunityContactRoles){
                                         mappCRole.put(ocr.ContactId , ocr.OpportunityId);
                                      system.debug('testMapRole' +mappCRole.get(ocr.ContactId));
                                      pr1.Opportunity__c = mappCRole.get(ocr.ContactId);
                                     }                      
                              }
        }
        }
    }