trigger accountopplineitems on OpportunityLineItem (After insert,after update,after delete) {
    set<id> oppset= new set<id>();
    map<id,integer> map1 = new map<id,integer>();
    if(trigger.isafter && (trigger.isinsert || trigger.isupdate)){
        for(OpportunityLineItem oli : trigger.new){
            oppset.add(oli.Opportunityid);
        }
    }
    if(trigger.isafter && (trigger.IsDelete || trigger.IsUpdate)){
        for(OpportunityLineItem oli : trigger.old){
            oppset.add(oli.Opportunityid);
        }
    }
        set<Id> accId = new set<Id>();
        for(Opportunity opp : [select id, name,Accountid,(select id, Product2Id, name from OpportunityLineItems)from Opportunity where id in : oppset]){
            accid.add(opp.Accountid);
        }
        set<Id> OppId = new set<Id>();
       for(account acc : [select id, name,CountLineItem__c , (select id,Opportunity.AccountId, name from Opportunities) from account where id in : accid]){
            for(Opportunity opp : acc.Opportunities){
                OppId.add(opp.Id);
            }
        }
        set<Id> proId = new set<Id>();
        for(Opportunity opp: [select id, name,Accountid,(select id, Product2Id, name from OpportunityLineItems)from Opportunity where id in : OppId]){
            for(OpportunityLineItem oli : opp.OpportunityLineItems){
                 proId.add(oli.Product2Id);
            }
            map1.put(opp.Accountid,proId.size());
        }
        list<account> acclist = new list<account>();
        for(Account acc: [select id, name , CountLineItem__c from account]){
            acc.CountLineItem__c = map1.get(acc.id);
            acclist.add(acc);
        }
    if(acclist.size() >0){
        update acclist;
    }
}