trigger UpdateAccountField on Opportunity (after insert ,after update, after delete) {
    set<id> setIds = New set<Id>();
    set<id> setContIds = New set<Id>();
    set<id> setContsIds = New set<Id>();
    map<id,string> mapContact = new map<id,string>();
    if(trigger.isinsert || trigger.isupdate){
        for(Opportunity opp : trigger.new ){
        setIds.add(opp.Id);
        system.debug('testsetIds1:'+setIds);
        }
    }
    if(trigger.isDelete){
        for(Opportunity opp : trigger.old){
        setIds.add(opp.Id);
        system.debug('testsetIds2:'+setIds);
        }
     }
    for(OpportunityContactRole oppcont : [select contact.accountid , OpportunityId  from OpportunityContactRole where OpportunityId   =: setIds]){
        setContIds.add(oppcont.contact.accountid);
        system.debug('testsetContIds:'+setContIds);
    }
    
    for(account acc: [select id,(select id from contacts) from account where id=:setContIds]){
        for(contact con:acc.contacts){
            setContsIds.add(con.id);
        system.debug('testsetContsIds:'+setContsIds);
        }
        
    }
    
    for(contact con : [select id,accountid,name,(select id,OpportunityId  from OpportunityContactRoles where OpportunityId != null) from contact where id=:setContsIds order by createddate ASC]){
        if(con.OpportunityContactRoles.size() > 2){
            mapContact.put(con.accountid,con.name);
         system.debug('testmapContact:'+mapContact);
            
        }
    }
    
    list<account> acclist = new list<account>();
    for(account acc:[select id,contact_name__c from account where id=:mapContact.keyset()]){
        acc.contact_name__c = string.valueof(mapContact.get(acc.id));
        acclist.add(acc);
        system.debug('testacclist:'+acclist);
    }
    if(acclist.size() > 0){
        update acclist;
    }

}