trigger CountOpportunityLineItemOnAccount on OpportunityLineItem (after insert ,after delete ,after update ,after undelete) {
    set<Id> setIds = new set<Id>();
    set<Id> accId = new set<Id>();
    Set<String> proId = new Set<String>();
    if((trigger.isInsert|| trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        for(OpportunityLineItem oli : trigger.new){
            setIds.add(oli.OpportunityId);
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        for(OpportunityLineItem oli : trigger.old){
            setIds.add(oli.OpportunityId);
        }
    }
    if(setIds.size() > 0){
        for ( Opportunity  opp : [select id , name ,AccountId from opportunity where id in: setIds]){
            accId.add(opp.AccountId);
        }
    }
    Map<id,account> mapacc = new Map<id,account>();
    for(Account acc :[select Id , Name, CountLineItem__c ,(select id,AccountId, name from opportunities ) from account where id in:accId]){
        for(opportunity opp : acc.opportunities){
            mapacc.put(opp.id, acc);
        }
    }
    Map<Id,integer> intMap = new Map<Id,integer>();
    Map<Id,integer> quantMap = new Map<Id,Integer>();
    if(mapacc.size() > 0){
        for(opportunity opp1 : [select id, name, (select id, name,Product2.name from OpportunityLineItems) from Opportunity where id in : mapacc.keySet()]){
            for(OpportunityLineItem oli :opp1.OpportunityLineItems){
             intmap.put(opp1.Id, opp1.OpportunityLineItems.size());
                 proId.add(oli.Product2.name);
            }
            quantMap.put(opp1.Id, proId.size());
            system.debug('testproduct--'+proId.size());
        }
    }
    if(accId.size() > 0){
        List<Account> accList = new List<Account>();
        for(account acc : [select id,CountLineItem__c,(select id from Opportunities) from account where id=: accId]){
            integer size=0;
            for(Opportunity opp : acc.Opportunities){
                if(intmap.containsKey(opp.id)){
                size = size + quantMap.get(opp.id);
              
            } 
            }
            system.debug('6'+intmap);
            acc.CountLineItem__c = size;
            accList.add(acc);
        }
        if(accList.Size() > 0){
            update accList;
        }
    }
}