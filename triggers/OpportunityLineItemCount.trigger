trigger OpportunityLineItemCount on OpportunityLineItem (after insert, after update, after delete , after undelete) {
    set<Id> setIds = new set<Id>();
    set<Id> setopp = new set<Id>();
    Map<id,OpportunityLineItem> mapp = new Map<id,OpportunityLineItem>();
    if((trigger.IsInsert || trigger.IsUpdate || trigger.IsUndelete) && trigger.isAfter){
       for(OpportunityLineItem oli : trigger.new){
        setIds.add(oli.id);
        setopp.add(oli.OpportunityId);
           mapp.put(oli.OpportunityId,oli);
    } 
    }
    if(trigger.isDelete  && trigger.isAfter){
       for(OpportunityLineItem oli : trigger.old){
        setIds.add(oli.id);
        setopp.add(oli.OpportunityId);
    } 
    }
    
    Map<Id,Account> mapAcc = new Map<Id,Account>();
    List<Opportunity> oppList = new List<Opportunity>();
    Set<Id> proId = new Set<Id>();
    for(opportunity opp : [select id, name , accountId,Account.No_Of_Count__c,(select id, name , product2Id from opportunityLineItems) from opportunity where id In:Mapp.keySet()]){
        mapAcc.put(opp.id, opp.Account);
        oppList.add(opp);
        for(opportunityLineItem oli : opp.opportunityLineItems){
            proId.add(oli.Product2Id);
        }
       system.debug('test'+ mapp.get(opp.id));
    }
    List<Account> accList = new List<Account>();
    for(Account acc: [select Id, name ,No_Of_Count__c from Account where id in: mapacc.values()]){
        for(opportunity opp : oppList){
            acc.No_Of_Count__c = proId.size();
            accList.add(acc);
        }
    }
    if(accList.size() > 0){
      update accList;
    }
    /*
     *11:08 AM
String fullname;
if(String.isNotBlank(fullname)){
fullname = fullname.trim();
List<String> nameslist = fullname.split(' ');
String firstName =  nameslist[0];
String LastName = '';
for(interger i=1;i<nameslist.size();i++){
    if(i == nameslist.size()-1){
        LastName = nameslist[i];
    }else{
        firstName = firstName+' '+nameslist[i];
    }
} 
}*/
}